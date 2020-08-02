//
//  CurrencyClient.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 02/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import Foundation

struct CurrencyQuoteResponse {
    public let abbreviation: String
    public let quote: Double
}

struct CurrencyNameResponse {
    public let abbreviation: String
    public let name: String
}

protocol CurrencyClientProtocol {
    func synchronizeQuotes(result: () -> Void)
}

class CurrencyClient: CurrencyClientProtocol {
    
    typealias CurrencyQuoteResult = (Result<[CurrencyQuoteResponse], Error>) -> Void
    typealias CurrencyNameResult = (Result<[CurrencyNameResponse], Error>) -> Void
    
    func getCurrenciesQuotes(result: (Result<[CurrencyQuoteResponse], Error>) -> Void) {
        // FIXME: Implementar método
    }
    
    func listCurrenciesNames(result: (Result<[CurrencyNameResponse], Error>) -> Void) {
        // FIXME: Implementar método
    }
    
    func synchronizeQuotes(result: () -> Void) {
        // FIXME: Implementar método
    }
    
    
}
