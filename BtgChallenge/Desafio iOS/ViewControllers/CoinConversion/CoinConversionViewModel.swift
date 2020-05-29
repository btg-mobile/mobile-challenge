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
    
    init(httpManager: HTTPManager<CurrencyRouter> = HTTPManager<CurrencyRouter>()) {
        _selectedCurrencyFrom.accept(FormattedCurrency(currencyCode: "BRL", currencyName: "Brazilian Real"))
        _selectedCurrencyTo.accept(FormattedCurrency(currencyCode: "USD", currencyName: "United States Dollar"))
        self.httpManager = httpManager
        self.service = CurrencyLayerService(httpManager: httpManager)
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
            //fire error on observable
            self.error.accept("Os campos de moeda de origem, destino e valor desejado para conversão são de preenchimento obrigatório.")
            self._isLoading.accept(false)
            return
        }
        if toCoin.currencyCode == "USD" {
            //all coins convert to USD
        } else {
            // converter toCoin para USD
            //
        }
//        service.getConversionRate(fromCoin: fromCoin.currencyCode, toCoin: toCoin.currencyCode) { (result) in
//            self._isLoading.accept(false)
//            if let conversionRate = result.result {
//                self.calculateFinalValue(response: conversionRate, fromCoin: fromCoin.currencyCode, toCoin: toCoin.currencyCode, amount: amount)
//            } else if let error = result.failure {
//                self.error.accept(error.localizedDescription)
//            }
//        }
    }
    
    func calculateFinalValue(response: CurrencyLiveResponse, fromCoin: String, toCoin: String, amount: String) {
        let fixedAmount = amount.replacingOccurrences(of: ",", with: "")
        let rate = response.quotes?[toCoin + fromCoin] ?? 0.0
        if rate == 0.0 {
            finalValue.accept("0.00".currencyInputFormatting())
        } else {
            let value = (fixedAmount.double / rate).stringValue.currencyFormatted
            finalValue.accept(value)
        }
        
        
    }
}
