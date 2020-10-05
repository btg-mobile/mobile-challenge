//
//  CurrencyQuoteModel.swift
//  iOS Giovane Barreira
//
//  Created by Giovane Barreira on 10/2/20.
//

import Foundation

struct QuotesModel: Codable {
    var allCurrencies: [String : Double]?
    
    enum CodingKeys: String, CodingKey {
        case allCurrencies = "quotes"
    }
}
