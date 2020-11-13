//
//  LiveExchangeResponse.swift
//  CurrencyConversor
//
//  Created by Erick Mitsugui Yamato on 09/11/20.
//

import Foundation

struct LiveExchangeResponse: Codable {
    let terms, privacy: String?
    let timestamp     : Int?
    let source        : String?
    let quotes        : [String: Double]
    let success       : Bool
    let error         : ErrorResponse?
}

struct ExchangeRate: Codable {
    let currency      : String
    let value         : Double
}

extension ExchangeRate {
    var formattedValue: String {
        return String(format: "%.2f", self.value)
    }
}
