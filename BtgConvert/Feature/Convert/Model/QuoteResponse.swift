//
//  QuoteModel.swift
//  BtgConvert
//
//  Created by Albert Antonio Santos Oliveira - AOL on 29/04/21.
//

import Foundation

struct QuoteResponse: Codable  {
    let success: Bool?
    let quotes: [String: Double]?
    
    func getQuotes() -> [QuoteModel] {
        guard let quotes = quotes else { return [QuoteModel]() }
        var quotesModel = [QuoteModel]()
        quotes.forEach { (key, value) in
            quotesModel.append(QuoteModel(ref: key, value: value))
        }
        return quotesModel
    }
}
