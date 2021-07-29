//
//  ListQuotesResponse.swift
//  Coin Converter
//
//  Created by Igor Custodio on 28/07/21.
//

import Foundation

struct ListQuotesResponse: Decodable {
    var success: Bool
    var source: String
    var quotes: [String: Double]
    
    func toQuote() -> [Quote] {
        return quotes.map { (key: String, value: Double) in
            let target = key.index(key.startIndex, offsetBy: source.count)
            return Quote(source: source, target: String(key[target...]), quote: value)
        }
        
    }
}

