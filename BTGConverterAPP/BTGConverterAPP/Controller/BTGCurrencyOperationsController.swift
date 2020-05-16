//
//  BTGCurrencyOperationsController.swift
//  BTGConverterAPP
//
//  Created by Ana Caroline de Souza on 16/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import Foundation

struct BTGCurrencyOperationsController {
    
    static func currencyToUSD(inputBaseDecimal: Decimal,to quotesToUsd: Double) -> String {
        
        let quotesDecimal : Decimal = NSNumber(floatLiteral: quotesToUsd).decimalValue
        let resultToUSDDecimal = inputBaseDecimal/quotesDecimal
        
        return formatNumberToCurrencyConverterVC(resultToUSDDecimal)
    }
    
    static private func formatNumberToCurrencyConverterVC(_ number: Decimal) -> String {
        var compoments = number.description.components(separatedBy: ".")
        return compoments[0] + ".\(compoments[1].removeFirst())\(compoments[1].removeFirst())"
    }
    
}
