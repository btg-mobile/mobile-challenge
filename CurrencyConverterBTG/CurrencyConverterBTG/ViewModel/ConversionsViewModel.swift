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
    var originText: Box<String> = Box(ConversionsViewModel.originDefaultText)
    var destinyText: Box<String> = Box(ConversionsViewModel.destinyDefaultText)
    
    var originCurrency: Box<Currency?> = Box(nil)
    var destinyCurrency: Box<Currency?> = Box(nil)
    
    weak var viewController: ConversionsViewController?
    
    init() {
        CurrencyLayerAPI.shared.fetchConversions { conversions in
            if let conversions = conversions {
                self.conversions = conversions
            }
        }
        
        originCurrency.bind { [unowned self] currency in
            if let currency = currency {
                self.originText.value = currency.code
            } else {
                self.originText.value = ConversionsViewModel.originDefaultText
            }
        }
        
        destinyCurrency.bind { [unowned self] currency in
            if let currency = currency {
                self.destinyText.value = currency.code
            } else {
                self.destinyText.value = ConversionsViewModel.destinyDefaultText
            }
        }
    }
}
