//
//  TextFieldDelegate.swift
//  MobileChallenge
//
//  Created by Gabriel Vicentin Negro on 18/11/24.
//

import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard var currentText = textField.text else { return true }
        guard let currentTextNSString = textField.text as? NSString else { return true }
        
        var afterCommaCount = 0
        var foundComma = false
        
        
        if string == "," {
            let newText = currentTextNSString.replacingCharacters(in: range, with: ".")
            currentText = newText
            textField.text = newText
            return false
        }
        
        if currentText.contains(".") {
            for char in currentText {
                if char == "." {
                    foundComma = true
                }
                if foundComma {
                    afterCommaCount += 1
                }
                if range.length > 0 {
                    return true
                }
                if afterCommaCount == 3 {
                    return false
                }
            }
        } else {
            if currentText.count > 10 {
                if range.length > 0 {
                    return true
                } else {
                    return false
                }
            }
        }
        
        return true
    }
}
