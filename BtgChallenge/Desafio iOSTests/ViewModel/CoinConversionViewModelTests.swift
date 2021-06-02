//
//  CoinConversionViewModelTests.swift
//  Desafio iOSTests
//
//  Created by Lucas Soares on 31/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift






class CoinConversionViewModelTests: CoinConversionViewModelProtocol {
    
    func didSelectNewCurrency(formattedCurrency: FormattedCurrency, source: CurrencySource) {
        if source == .to {
            self.selectedCurrencyTo.accept(formattedCurrency)
        } else if source == .from {
            self.selectedCurrencyFrom.accept(formattedCurrency)
        }
    }
    
    var isLoading: BehaviorRelay<Bool>
    
    var disposeBag: DisposeBag
    
    var selectedCurrencyFrom: BehaviorRelay<FormattedCurrency?>
    
    var selectedCurrencyTo: BehaviorRelay<FormattedCurrency?>
    
    var error: BehaviorRelay<String?>
    
    var amount: BehaviorRelay<String?>
    
    var finalValue: BehaviorRelay<String?>
    
    let usdCurrency: FormattedCurrency
    
    var EXPECTED_RATE = 5.92 //Euro -> brazilian
    var EXPECTED_INTERMEDIARY_RATE: Double? //Brazilian -> Dollar
    
    init() {
        
        disposeBag = DisposeBag()
        
        isLoading = BehaviorRelay<Bool>(value: false)
        
        selectedCurrencyFrom = BehaviorRelay<FormattedCurrency?>(value: FormattedCurrency(currencyCode: "BRL", currencyName: "Brazilian Real"))
        
        selectedCurrencyTo = BehaviorRelay<FormattedCurrency?>(value: FormattedCurrency(currencyCode: "EUR", currencyName: "Euro"))
        
        error = BehaviorRelay<String?>(value: nil)
        
        amount = BehaviorRelay<String?>(value: nil)
        
        finalValue = BehaviorRelay<String?>(value: nil)
        
        usdCurrency = FormattedCurrency(currencyCode: "USD", currencyName: "United States Dollar")
    }
    
    
    func getConversionValue() {
        guard let amount = amount.value, let toCoin = self.selectedCurrencyTo.value, let _ = selectedCurrencyFrom.value else {
            self.error.accept(Constants.Messages.coinConversionError)
            return
        }
        let fixedAmount = amount.replacingOccurrences(of: ",", with: "").double
        var mFinalValue = 0.0
        
        if toCoin.currencyCode == usdCurrency.currencyCode {
            if EXPECTED_RATE >= 1.0 {
                mFinalValue = fixedAmount / EXPECTED_RATE
            } else {
                mFinalValue = fixedAmount * EXPECTED_RATE
            }
        } else {
            
            guard let intermediaryRate = EXPECTED_INTERMEDIARY_RATE, EXPECTED_RATE >= 0.0 else {
                return
            }
            
//           convert fromCoin to USD
            let firstValue = intermediaryRate >= 1.0 ? (fixedAmount / intermediaryRate) : (fixedAmount * intermediaryRate) // 187
            
            if EXPECTED_RATE >= 1.0 {
                mFinalValue = firstValue / EXPECTED_RATE
            } else {
                mFinalValue = firstValue * EXPECTED_RATE
            }
  
            EXPECTED_INTERMEDIARY_RATE = nil
        }
        self.finalValue.accept(mFinalValue.stringValue.currencyFormatted)
    }
    
    
    func formatMoney(value: String) -> String {
        return value.currencyInputFormatting()
    }
    
    
}
