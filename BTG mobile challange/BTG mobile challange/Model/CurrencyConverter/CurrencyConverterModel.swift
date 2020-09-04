//
//  CurrencyConverterModel.swift
//  BTG mobile challange
//
//  Created by Uriel Barbosa Pinheiro on 04/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

import Foundation

struct CurrencyConverterModel: Codable {
    let success: Bool?
    let source: String?
    let quotes: [String: Double]?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case source = "source"
        case quotes = "quotes"
    }
}
