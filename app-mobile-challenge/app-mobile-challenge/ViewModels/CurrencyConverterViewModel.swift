//
//  CurrencyConverterViewModel.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 27/11/20.
//

import UIKit

protocol CurrencyConverterService: class {
    func updateView()
}

final class CurrencyConverterViewModel {
    @UserDefaultAccess(key: "USD", defaultValue: "USD")
    private var fromCurrencyStorage: String
    
    @UserDefaultAccess(key: "USD", defaultValue: "USD")
    private var toCurrencyStorage: String
    
    private let coordinator: CurrencyConverterCoordinatorService
    private weak var delegate: CurrencyConverterService?
    
    
    var fromCurrency: String {
        return fromCurrencyStorage
    }
    
    var currencyValue: String = ""
    
    var toCurrency: String {
        return toCurrencyStorage
    }
    
    init(coordinator: CurrencyConverterCoordinatorService) {
        self.coordinator = coordinator
    }
    
    func pickSupporteds() {
        coordinator.showSupporteds()
    }
    
    func newValue(value: Int) -> String {
        switch value {
        case 0...9:
            currencyValue.append(String(value))
            break
        case 10:
            if(isValidComma()) { currencyValue.append(",") }
            break
        case 11:
            if (!currencyValueIsEmpty()) {
                currencyValue.removeLast()
            }
            break
        default:
            break
        }
        return currencyValue
    }
    
    private func isValidComma() -> Bool {
        return !currencyValue.contains(",")
    }
    
    func currencyValueIsEmpty() -> Bool {
        return currencyValue == ""
    }
}
