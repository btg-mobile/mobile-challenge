//
//  CoinConversionViewModel.swift
//  Desafio iOS
//
//  Created by Lucas Soares on 28/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
protocol CoinConversionViewModelProtocol: CurrencyListViewControllerDelegate {
    
    var isLoading: BehaviorRelay<Bool> { get }
    var disposeBag: DisposeBag { get }
    var selectedCurrencyFrom: BehaviorRelay<FormattedCurrency?> { get }
    var selectedCurrencyTo: BehaviorRelay<FormattedCurrency?> { get }
    var error: BehaviorRelay<String?> { get }
    var amount: BehaviorRelay<String?> { get }
    var finalValue: BehaviorRelay<String?> { get }
    func getConversionValue()
    func formatMoney(value: String) -> String
}


class CoinConversionViewModel {
    
    private let _disposeBag = DisposeBag()
    private let _selectedCurrencyFrom = BehaviorRelay<FormattedCurrency?>(value: nil)
    private let _selectedCurrencyTo = BehaviorRelay<FormattedCurrency?>(value: nil)
    private let _amount = BehaviorRelay<String?>(value: nil)
    private let httpManager: HTTPManager<CurrencyRouter>
    private let _isLoading = BehaviorRelay<Bool>(value: false)
    private let _error = BehaviorRelay<String?>(value: nil)
    private let service: CurrencyLayerService
    private let _finalValue = BehaviorRelay<String?>(value: "0")
    private let USD_CURRENCY: FormattedCurrency
    private var intermediaryRate: Double?
    
    init(httpManager: HTTPManager<CurrencyRouter> = HTTPManager<CurrencyRouter>()) {
        self.USD_CURRENCY = FormattedCurrency(currencyCode: "USD", currencyName: "United State Dollar")
        _selectedCurrencyFrom.accept(FormattedCurrency(currencyCode: "BRL", currencyName: "Brazilian Real"))
        _selectedCurrencyTo.accept(USD_CURRENCY)
        self.httpManager = httpManager
        self.service = CurrencyLayerService(httpManager: httpManager)
        
    }
    
    func calculateFinalValue(response: CurrencyLiveResponse, fromCoin: String, toCoin: String, amount: String) {
        
        let fixedAmount = amount.replacingOccurrences(of: ",", with: "").double
        var firstValue: Double = 0
        var finalValue: Double = 0
        if let intermediaryRate = intermediaryRate, intermediaryRate > 0.0 {
            let usdRate = response.quotes?[USD_CURRENCY.currencyCode + fromCoin] ?? 0.0 //fromCoin to Dollar Rate
            
            firstValue = usdRate >= 1.0 ? (fixedAmount / usdRate) : (fixedAmount * usdRate) //value from fromCoin to USD
            
            if intermediaryRate >= 1 {
                if intermediaryRate > usdRate {
                    finalValue = firstValue * intermediaryRate //value from USD to toCoin
                } else {
                    finalValue = firstValue / intermediaryRate //value from USD to toCoin
                }
            } else {
                finalValue = firstValue / intermediaryRate //value from USD to toCoin
            }
            
        } else {
            let rate = response.quotes?[toCoin + fromCoin] ?? 0.0
            if rate == 0.0 {
                finalValue = 0 //value from fromCoin to toCoin if toCOin is USD
            } else {
                if rate >= 1 {
                    finalValue = (fixedAmount / rate) //value from fromCoin to toCoin if toCOin is USD
                } else {
                    finalValue = (fixedAmount * rate) //value from fromCoin to toCoin if toCOin is USD
                }
                
            }
        }
        self.finalValue.accept(finalValue.stringValue.currencyFormatted)
    }
}
extension CoinConversionViewModel: CoinConversionViewModelProtocol {
    
    var isLoading: BehaviorRelay<Bool> {
        return _isLoading
    }
    
    var error: BehaviorRelay<String?> {
        return _error
    }
    
    var finalValue: BehaviorRelay<String?>{
        return _finalValue
    }
    
    var amount: BehaviorRelay<String?> {
        return _amount
    }
    
    var selectedCurrencyFrom: BehaviorRelay<FormattedCurrency?> {
        return _selectedCurrencyFrom
    }
    
    var selectedCurrencyTo: BehaviorRelay<FormattedCurrency?> {
        return _selectedCurrencyTo
    }
    
    
    func formatMoney(value: String) -> String {
        return value.currencyInputFormatting()
    }
    
    var disposeBag: DisposeBag {
        return _disposeBag
    }
    
    func didSelectNewCurrency(formattedCurrency: FormattedCurrency, source: CurrencySource) {
        if source == .from {
            self.selectedCurrencyFrom.accept(formattedCurrency)
        } else {
            self.selectedCurrencyTo.accept(formattedCurrency)
        }
    }
    
    func getConversionValue() {
        self._isLoading.accept(true)
        guard let fromCoin = self.selectedCurrencyFrom.value, let toCoin = self.selectedCurrencyTo.value, let amount = self.amount.value, amount != "" else {
            self.error.accept(Constants.Messages.coinConversionError)
            self._isLoading.accept(false)
            return
        }
        
        if toCoin.currencyCode == USD_CURRENCY.currencyCode {
            
            //all coins convert to USD
            service.getConversionRate(fromCoin: fromCoin.currencyCode, toCoin: toCoin.currencyCode) { (result) in
                self._isLoading.accept(false)
                if let conversionRate = result.result {
                    //resets previous information from intermediaryRate
                    self.intermediaryRate = nil
                    if !(conversionRate.success ?? false), let conversionError = conversionRate.error {
                        self.error.accept(conversionError.getErrorMessageByCode())
                    } else {
                        self.calculateFinalValue(response: conversionRate, fromCoin: fromCoin.currencyCode, toCoin: toCoin.currencyCode, amount: amount)
                    }
                } else if let error = result.failure {
                    self.error.accept(error.localizedDescription)
                }
            }
            
        } else {
            // converter toCoin to USD
            service.getConversionRate(fromCoin: toCoin.currencyCode, toCoin: USD_CURRENCY.currencyCode) { (result) in
                if let conversionRate = result.result {
                    self.intermediaryRate = conversionRate.quotes?[self.USD_CURRENCY.currencyCode + toCoin.currencyCode]
                    if !(conversionRate.success ?? false), let conversionError = conversionRate.error {
                        self.error.accept(conversionError.getErrorMessageByCode())
                    }else {
                        //chain request if there is no error.
                        self.service.getConversionRate(fromCoin: fromCoin.currencyCode, toCoin: self.USD_CURRENCY.currencyCode) { (secondResult) in
                            self.isLoading.accept(false)
                            if let secondConversionRate = secondResult.result {
                                if !(conversionRate.success ?? false), let conversionError = conversionRate.error {
                                    self.error.accept(conversionError.getErrorMessageByCode())
                                } else {
                                    self.calculateFinalValue(response: secondConversionRate, fromCoin: fromCoin.currencyCode, toCoin: toCoin.currencyCode, amount: amount)
                                }
                            } else if let secondError = secondResult.failure {
                                self.error.accept(secondError.localizedDescription)
                            }
                        }
                    }
                    
                    
                } else if let error = result.failure {
                    self.error.accept(error.localizedDescription)
                }
            }
        }
    }
}
