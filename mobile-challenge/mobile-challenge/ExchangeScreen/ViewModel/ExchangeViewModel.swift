//
//  ExchangeViewModel.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation

class ExchangeViewModel {
    
    var fromCurrency: CurrencyModel?
    var toCurrency: CurrencyModel?
    
    func convertCurrencies(value: String) -> String {
        guard let value = Double(value) else { return "" }
        guard let fromValue = fromCurrency?.value else { return "" }
        guard let toValue = toCurrency?.value else { return "" }
        
        let dollarValue = fromValue*value
        let finalValue = toValue*dollarValue
        
        return String(format: "%.2f", finalValue)
    }
}
