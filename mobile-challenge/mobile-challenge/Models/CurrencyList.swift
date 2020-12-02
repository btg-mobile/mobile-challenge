//
//  CurrencyList.swift
//  mobile-challenge
//
//  Created by gabriel on 29/11/20.
//

import Foundation

struct CurrencyList: Decodable {
    let currencies: [Currency]
    
    enum CodingKeys: CodingKey {
        case currencies
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let dict = try container.decode([String:String].self, forKey: .currencies)
        currencies = dict.map({Currency(name: $0.value, symbol: $0.key)})
    }
}
