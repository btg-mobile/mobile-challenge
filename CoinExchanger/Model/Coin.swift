//
//  Coin.swift
//  CoinExchanger
//
//  Created by Junior on 03/09/21.
//

import Foundation

class Coin: Codable {
    var cod: String?
    var name: String?
    var quote: Double?
    
    init(_ cod: String? = nil,
         _ name: String? = nil,
         _ quote: Double? = nil) {
        self.cod = cod
        self.name = name
        self.quote = quote
    }
    
    enum CodingKeys: String, CodingKey {
        case cod = "codigo"
        case name = "nome"
        case quote = "cotacao"
    }
}

// MARK: getResponse List
class GetCoinList: GetResponse {
    var items: [Coin]?
    
    init(_ items: [Coin]?, _ success: Bool?) {
        super.init(success)
        self.items = items
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode([Coin].self, forKey: .items)
    }
    
    enum CodingKeys: String, CodingKey {
        case items = "currencies"
    }
}
