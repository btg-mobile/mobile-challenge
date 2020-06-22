//
//  DecimalExtensions.swift
//  CurrencyConverterBTG
//
//  Created by Silvia Florido on 21/06/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation

extension Decimal {
    
    static func fromDouble(_ value: Double) -> Decimal {
        let decimal: Decimal = NSNumber(floatLiteral: value).decimalValue
        return decimal
    }
    
    static func fromString(_ value: String) -> Decimal? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .decimal

        if let number = formatter.number(from: value) {
            let decimal = number.decimalValue
            return decimal
        } else {
            return nil
        }
    }
    
    func toString() -> String? {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: self as NSDecimalNumber)
    }
    
}
