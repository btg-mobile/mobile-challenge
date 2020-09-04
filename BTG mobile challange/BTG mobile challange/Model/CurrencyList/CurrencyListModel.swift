//
//  CurrencyListModel.swift
//  BTG mobile challange
//
//  Created by Uriel Barbosa Pinheiro on 03/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

struct CurrencyListModel: Codable {
    let success: Bool?
    let error: ModelError?
    let currencies: [String: String]?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case error = "error"
        case currencies = "currencies"
    }
}

struct ModelError: Codable {
    let code: Int?
    let type: String?
    let info: String?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case type = "type"
        case info = "info"
    }
}
