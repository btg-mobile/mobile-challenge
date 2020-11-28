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
    
    
    public var fromCurrency: String {
        return fromCurrencyStorage
    }
    
    public var currencyValue: String = ""
    
    public var toCurrency: String {
        return toCurrencyStorage
    }
    
    init(coordinator: CurrencyConverterCoordinatorService) {
        self.coordinator = coordinator
    }
    //Coordinators
    public func pickSupporteds() {
        coordinator.showSupporteds()
    }
    //End Coordinators
    
    public func newValue(value: Int) -> String {
        switch value {
        case 0...9:
            currencyValue.append(String(value))
        case 10:
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
    public func calculateConvertion() -> String {
        return currencyValue
    }
    
    private func isValidComma() -> Bool {
        return !currencyValue.contains(",")
    }
    
}
