//
//  RealTimeRates.swift
//  CurrencyChallenge
//
//  Created by Higor Chaves Peres on 16/12/20.
//

import Foundation

struct RealTimeRates {
    let success: Bool
    let terms: String
    let privacy: String
    let timestamp: Date
    let source: String
    let quotes: [String : Double]
}


extension RealTimeRates: Codable {
    
    fileprivate enum CodingKeys: String, CodingKey {
        case success
        case terms
        case privacy
        case timestamp
        case source
        case quotes
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(success, forKey: .success)
        try container.encode(terms, forKey: .terms)
        try container.encode(privacy, forKey: .privacy)
        try container.encode(timestamp, forKey: .timestamp)
        try container.encode(source, forKey: .source)
        try container.encode(quotes, forKey: .quotes)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success) ?? false
        terms = try values.decodeIfPresent(String.self, forKey: .terms) ?? ""
        privacy = try values.decodeIfPresent(String.self, forKey: .privacy) ?? ""
        
        timestamp = try values.decodeIfPresent(Date.self, forKey: .timestamp) ?? Date()
        
        source = try values.decodeIfPresent(String.self, forKey: .source) ?? ""
 
        quotes = try values.decodeIfPresent([String:Double].self, forKey: .quotes) ?? [:]
    }
}
