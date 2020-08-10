//
//  Quotes.swift
//  BTGPactual-HelioVieira
//
//  Created by Helio Junior on 07/08/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import Foundation

protocol QuotesResponse: Decodable {
    var success: Bool {get}
}

struct Quotes: QuotesResponse {
    let success: Bool
    let quotes: [String:Double]
    
    func getPriceQuote(from currencyIn: String, to currencyOut: String) -> Double? {
        
        let keyIn = "USD" + currencyIn
        let keyOut = "USD" + currencyOut
        
        guard let valueIn = quotes[keyIn], let valueOut = quotes[keyOut] else {return nil}
        
        return nil
    }
    
    func getPriceQuote(to currency: String) -> Double? {
        let key = "USD" + currency
        guard let value = quotes[key] else {return nil}
        return value
    }
}
