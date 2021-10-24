//
//  NumberTextField.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 24/10/21.
//

import UIKit

class NumberTextField: UITextField {
    
    var didUpdateValue: ((Float)-> Void)?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension NumberTextField {
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = textField.text!
        
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, textField.text!.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        text = formatter.string(from: number)!
        didUpdateValue?(number.floatValue)
    }
}
