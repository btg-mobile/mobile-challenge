//
//  Double+Conversion.swift
//  CurrencyConversor
//
//  Created by Erick Mitsugui Yamato on 13/11/20.
//

import Foundation

extension Double {
    
    init?(_ string: String, withDecimalReplacement: Bool, charToReplace: String = StringIdentifier.decimalSymbol.getString()) {
        
        var stringValue = string
        
        if withDecimalReplacement {
            stringValue = string.replacingOccurrences(of: charToReplace,
                                                      with: StringIdentifier.doubleSymbol.getString())
        }
        
        self.init(stringValue)
    }
}
