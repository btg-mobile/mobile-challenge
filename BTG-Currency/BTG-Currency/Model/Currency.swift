//
//  Currency.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 27/10/21.
//

import Foundation

public struct Currency {
    public var value: Decimal
    public var symbol: String
    
    public init(value: Decimal, symbol: String) {
        self.value = value
        self.symbol = symbol
    }
}

extension Currency: CustomStringConvertible {
    public var description: String {
        let outputLocale = Locale(identifier: symbol)
        let currentLocale = Locale.current
        
        let formatter = NumberFormatter()
        formatter.locale = outputLocale
        formatter.numberStyle = .currency
        formatter.groupingSize = 3
        formatter.decimalSeparator = currentLocale.decimalSeparator // ","
        formatter.groupingSeparator = currentLocale.groupingSeparator
        
        if let output = formatter.string(from: NSDecimalNumber(decimal: value)) {
            return output
        } else {
            return "$" + String(format: "%.3f", value as CVarArg)
        }
    }
}
