//
//  String+Extension.swift
//  BtgConvert
//
//  Created by Albert Antonio Santos Oliveira - AOL on 01/05/21.
//

import Foundation

extension String {
    
    var toCurrrency: String {
        get {
            var number: NSNumber!
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.locale = Locale(identifier: "pt_BR")
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2

            var amountWithPrefix = self

            let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
            amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count ), withTemplate: "")

            let double = (amountWithPrefix as NSString).doubleValue
            number = NSNumber(value: (double / 100))

            guard let n = number, n != 0 as NSNumber else {
                return "0,00"
            }
            return formatter.string(from: number)!
        }
    }
    
    func parseWhiteSpace() -> String {
        return self.replacingOccurrences(of: " ", with: "\u{A0}")
    }
    
    var toDoubleForced: Double? {
        let string = self.parseWhiteSpace().replacingOccurrences(of: "+", with: "")

        if let value: Double = {
            let currency = NumberFormatter.create()
            currency.numberStyle = .currency
            
            return currency.number(from: string) as? Double
        }() { return value }
        
        if let value: Double = {
            let percent = NumberFormatter.create()
            percent.numberStyle = .percent
            percent.multiplier = 1.0
            
            return percent.number(from: string) as? Double
        }() { return value }
        
        return self.toDouble
    }
    
    var toDouble: Double? {
        let formatter = NumberFormatter.create()
        let string = self.replacingOccurrences(of: "+", with: "")
        
        if let value = formatter.number(from: string)?.doubleValue {
            return value
        }
        
        return Double(self)
    }
    
//    var doubleValue: Double {
//        get {
//            let formatter = NumberFormatter()
//            formatter.numberStyle = .decimal
//            let number = formatter.number(from: self)
//            return number?.doubleValue ?? 0.0
//        }
//    }
        
}
