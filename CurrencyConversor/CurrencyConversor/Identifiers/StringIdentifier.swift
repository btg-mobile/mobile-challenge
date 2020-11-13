//
//  StringIdentifier.swift
//  CurrencyConversor
//
//  Created by Erick Mitsugui Yamato on 06/11/20.
//

import Foundation

enum StringIdentifier: String, CustomIdentifier {
    
    // Commons
    case ok
    case cancel
    
    // CurrencyViewController
    case currencies
    
    // ConverterViewController
    case availableCurrencies
    case origin
    case destiny
    case typeValuePlaceholder
    case currencyConverted
    
    // Double Conversion
    case doubleSymbol
    case decimalSymbol
    
}

extension StringIdentifier {
    
    func getString() -> String {
        return String(withCustomIdentifier: self)
    }
    
    func getLocalized(number: Int) -> String {
        return String(format: getString(), number)
    }
    
}
