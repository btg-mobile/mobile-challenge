//
//  CurrencyQuotes.swift
//  mobile-challenge
//
//  Created by gabriel on 29/11/20.
//

import Foundation

struct CurrencyQuotes: Decodable {
    let lastUpdate: Date
    let source: String
    let quotes: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case quotes, source, lastUpdate = "timestamp"
    }
    
    init(from decoder: Decoder) throws {
        // Decoding manually is necessary due to Date deserialization
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let timestamp = try container.decode(TimeInterval.self, forKey: .lastUpdate)
        lastUpdate = Date(timeIntervalSince1970: timestamp)
                
        source = try container.decode(String.self, forKey: .source)
        quotes = try container.decode([String: Double].self, forKey: .quotes)
    }
}
