//
//  KeyboardViewModel.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import Foundation

final class KeyboardViewModel {
    
    public var currencyValue: String = ""
    
    func convertValue(index: Int) -> String {
        var value: Int = 0
        switch index {
        case 0:
            value = 7
        case 1:
            value = 8
        case 2:
            value = 9
        case 3:
            value = 4
        case 4:
            value = 5
        case 5:
            value = 6
        case 6:
            value = 1
        case 7:
            value = 2
        case 8:
            value = 3
        case 9:
            value = 0
        default:
            value = index
        }
        
        return computedValue(value: value)
    }
    
    public func computedValue(value: Int) -> String {
        switch value {
        case 0...9:
            currencyValue.append(String(value))
        case 10:
            if(currencyValueIsEmpty()) { currencyValue.append("0") }
            if(isValidComma()) { currencyValue.append(",") }
        case 11:
            if (!currencyValueIsEmpty()) { currencyValue.removeLast() }
        default:
            break
        }
        return currencyValue
    }
    
    public func currencyValueIsEmpty() -> Bool {
        return currencyValue == ""
    }
    
    
    private func isValidComma() -> Bool {
        return !currencyValue.contains(",")
    }
}
