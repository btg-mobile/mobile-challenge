//
//  BTGCurrencyConverterVCController.swift
//  BTGConverterAPP
//
//  Created by Ana Caroline de Souza on 15/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import Foundation

protocol CurrencyConverterController {
    func getCurrencyConversion(baseCurrency: String, targetCurrency: String, inputDecimal: Decimal)
    func validateUserInput(userValueInput: String?, baseCurrency: String? , targetCurrency: String?) -> Bool
}

struct BTGCurrencyConverterController: CurrencyConverterController {
    
    weak var view : CurrencyResultHandler?
    var quotesController = BTGCurrencyQuotesController()
    
    init(view: CurrencyResultHandler) {
        self.view = view
        quotesController.loadQuotes()
    }
    
    func getCurrencyConversion(baseCurrency: String, targetCurrency: String, inputDecimal: Decimal) {
        print("\(baseCurrency) + \(targetCurrency) + \(inputDecimal)")
        
        if quotesController.getQuotes() == nil {
            quotesController.loadQuotes()
        }
        
        if let quotes = quotesController.getQuotes() {
            if baseCurrency != "USD" && targetCurrency == "USD" {
                let quotesDecimal : Decimal = NSNumber(floatLiteral: quotes[targetCurrency+baseCurrency]!).decimalValue
                

                let resultToUSDDecimal = inputDecimal/quotesDecimal
                var compoments = resultToUSDDecimal.description.components(separatedBy: ".")
                let formatted = compoments[0] + ".\(compoments[1].removeFirst())\(compoments[1].removeFirst())"
                
                view?.setCurrencyConversionResult(currencyConvertedResult: "\(formatted) \(targetCurrency)")
            }
            
        } else {
            view?.showErrorMessage(message: quotesController.getLastError())
        }
        
    }
    
    func validateUserInput(userValueInput: String?, baseCurrency: String? , targetCurrency: String?) -> Bool {
        
        guard let baseCurrency = baseCurrency , let targetCurrency = targetCurrency else {
            view?.showErrorMessage(message: BTGCurrencyErrorConstants.currenciesAreEmpty.rawValue)
            return false
        }
        
        if baseCurrency == targetCurrency {
            view?.showErrorMessage(message: BTGCurrencyErrorConstants.currenciesAreTheSame.rawValue)
            return false
        }
        
        guard let userValueInput = userValueInput else {
            view?.showErrorMessage(message: BTGCurrencyErrorConstants.currencyEmptyTextField.rawValue)
            return false
        }
        
        if Decimal(string: userValueInput) != nil {
            return true
        } else if userValueInput.isEmpty {
            view?.showErrorMessage(message: BTGCurrencyErrorConstants.currencyEmptyTextField.rawValue)
            return false
        } else {
            view?.showErrorMessage(message: BTGCurrencyErrorConstants.invalidCurrency.rawValue)
            return false
        }
    }
    
}


