//
//  ConversionsViewModel.swift
//  CurrencyConverterBTG
//
//  Created by Alex Nascimento on 23/03/21.
//

import Foundation

class ConversionsViewModel {
    
    var conversions: [Conversion]?
    
    static private let originDefaultText = "Choose a currency to convert from"
    static private let destinyDefaultText = "Choose a currency to convert to"

    private var validatedAmount: Box<Double?> = Box(nil)
    var originCurrency: Box<Currency?> = Box(nil)
    var destinyCurrency: Box<Currency?> = Box(nil)
    
    var amountText: Box<String?> = Box(nil)
    var resultText: Box<String?> = Box(nil)
    var originText: Box<String> = Box(ConversionsViewModel.originDefaultText)
    var destinyText: Box<String> = Box(ConversionsViewModel.destinyDefaultText)
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.currencyDecimalSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    
    weak var viewController: ConversionsViewController?
    
    init() {
        fetchConversions()
        
        originCurrency.bind { [unowned self] currency in
            if let currency = currency {
                self.originText.value = currency.code
                tryCalculation()
            } else {
                self.originText.value = ConversionsViewModel.originDefaultText
            }
        }
        
        destinyCurrency.bind { [unowned self] currency in
            if let currency = currency {
                self.destinyText.value = currency.code
                tryCalculation()
            } else {
                self.destinyText.value = ConversionsViewModel.destinyDefaultText
            }
        }
    }
    
    func didUpdateTextField(with text: String?) {
        if let text = text {
            if let amount = numberFormatter.number(from: text)?.doubleValue {
                validatedAmount.value = amount
                tryCalculation()
            } else {
                // try with different decimal separator
                changeDecimalSeparator()
                if let amount = numberFormatter.number(from: text)?.doubleValue {
                    validatedAmount.value = amount
                    tryCalculation()
                } else {
                    // Invalid input
                    resultText.value = "Invalid Input"
                }
            }
        } else {
            validatedAmount.value = nil
        }
    }
    
    private func changeDecimalSeparator() {
        numberFormatter.decimalSeparator = numberFormatter.decimalSeparator == "." ? "," : "."
    }
    
    private func tryCalculation() {
        if let origin = originCurrency.value,
           let destiny = destinyCurrency.value,
           let amount = validatedAmount.value {
            CurrencyLayerAPI.shared.fetchConversions { [unowned self] conversions in
                if let conversions = conversions {
                    self.conversions = conversions
                    
                    if let result = Conversion.convert(from: origin, to: destiny, conversions: conversions, amount: amount) {
                        resultText.value = numberFormatter.string(for: result)
                    }
                }
            }
        }
    }
    
    private func fetchConversions() {
        CurrencyLayerAPI.shared.fetchConversions { [unowned self] conversions in
            if let conversions = conversions {
                self.conversions = conversions
            }
        }
    }
}
