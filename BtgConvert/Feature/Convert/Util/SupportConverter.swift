//
//  SupportConvert.swift
//  BtgConvert
//
//  Created by Albert Antonio Santos Oliveira - AOL on 01/05/21.
//

import Foundation

class SupportConverter {
    
    let quotes: [QuoteModel]?
    let value: Double?
    let fromRef: String?
    let toRef: String?
    var result: Double?
    
    init(quotes: [QuoteModel], value: Double, fromRef: String, toRef: String) {
        self.quotes = quotes
        self.value = value
        self.fromRef = fromRef
        self.toRef = toRef
    }
        
    func convert(completation: @escaping (Double) -> Void) {
        guard let value = value, let fromCurrency = self.quotes?.filter({$0.ref == fromRef}).first,
              let toCurrency = self.quotes?.filter({$0.ref == toRef}).first else {
            return
        }
       completation((value * fromCurrency.value) / toCurrency.value)
    }

}
