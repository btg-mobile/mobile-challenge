//
//  String+Extensions.swift
//  Desafio-BTG
//
//  Created by Euclides Medeiros on 04/04/21.
//

import Foundation

public extension String {
    
    func currencyInputFormatting() -> String {
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.locale = Locale(identifier: "pt_BR")
        
        var amountWithPrefix = self
        
        let regex = try! NSRegularExpression(pattern: "[ˆ0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        guard number != 0 as NSNumber else {
            return ""
            
        }
        return formatter.string(from: number)!
    }
}
