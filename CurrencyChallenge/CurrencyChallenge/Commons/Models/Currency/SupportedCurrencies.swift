//
//  SupportedCurrencies.swift
//  CurrencyChallenge
//
//  Created by Higor Chaves Peres on 16/12/20.
//

import Foundation

struct SupportedCurrencies {
    let success: Bool
    let terms: String
    let privacy: String
    let currencies: [String : String]
    
}

extension SupportedCurrencies: Codable {
    
    fileprivate enum CodingKeys: String, CodingKey {
        case success
        case terms
        case privacy
        case currencies
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(success, forKey: .success)
        try container.encode(terms, forKey: .terms)
        try container.encode(privacy, forKey: .privacy)
        try container.encode(currencies, forKey: .currencies)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success) ?? false
        terms = try values.decodeIfPresent(String.self, forKey: .terms) ?? ""
        privacy = try values.decodeIfPresent(String.self, forKey: .privacy) ?? ""
        
        currencies = try values.decodeIfPresent([String:String].self, forKey: .currencies) ?? [:]
    }
}

