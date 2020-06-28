//
//  QuotesContainerModel.swift
//  Coin Converter
//
//  Created by Jeferson Hideaki Takumi on 27/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

import Foundation

struct QuotesContainerModel: Decodable {
    let success: Bool
    let terms: String
    let privacy: String
    let timestamp: Int
    let source: String
    let quotes: [QuoteModel]
    
    private enum QuotesModelKey: String, CodingKey {
        case success
        case terms
        case privacy
        case timestamp
        case source
        case quotes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: QuotesModelKey.self)
        success = try container.decode(Bool.self, forKey: .success)
        terms = try container.decode(String.self, forKey: .terms)
        privacy = try container.decode(String.self, forKey: .privacy)
        timestamp = try container.decode(Int.self, forKey: .timestamp)
        source = try container.decode(String.self, forKey: .source)
        
        let date: Date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        
        let quotesObject: [String: Double] = try container.decode([String: Double].self, forKey: .quotes)
        var quotes: [QuoteModel] = []
        for (key,value) in quotesObject {
            let newKey: String = String(key.dropFirst(source.count))
            quotes.append(QuoteModel(symbol: newKey, price: value, source: source, updateDate: date))
        }

        self.quotes = quotes
    }
}
