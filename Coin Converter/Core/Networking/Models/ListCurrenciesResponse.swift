//
//  ListCurrenciesResponse.swift
//  Coin Converter
//
//  Created by Igor Custodio on 28/07/21.
//

import Foundation

struct ListCurrenciesResponse: Decodable {
    var success: Bool
    var currencies: [String: String]
    
    func toCurrency() -> [Currency] {
        return currencies.map { Currency(initials: $0, extendedName: $1) }
        
    }
}
