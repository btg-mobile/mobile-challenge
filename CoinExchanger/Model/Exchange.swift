//
//  Exchange.swift
//  CoinExchanger
//
//  Created by Junior on 03/09/21.
//

import Foundation

class Exchange: Codable {
    var cod: String?
    var value: Double?
    
    init(_ cod: String? = nil,
         _ value: Double? = nil) {
        self.cod = cod
        self.value = value
    }
    
    enum CodingKeys: String, CodingKey {
        case cod = "codigo"
        case value = "valor"
    }
}

// MARK: getResponse List
class GetExchangeList: GetResponse {
    var source: String?
    var quotes: [Exchange]?
    
    init(_ quotes: [Exchange]?, _ success: Bool?) {
        super.init(success)
        self.quotes = quotes
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        quotes = try container.decode([Exchange].self, forKey: .quotes)
    }
    
    enum CodingKeys: String, CodingKey {
        case quotes = "quotes"
    }
}
