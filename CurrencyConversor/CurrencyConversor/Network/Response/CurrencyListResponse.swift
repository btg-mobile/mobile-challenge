//
//  CurrencyListResponse.swift
//  CurrencyConversor
//
//  Created by Erick Mitsugui Yamato on 10/11/20.
//

import Foundation

struct CurrencyListResponse: Codable {
    let currencies: [String: String]?
    let success   : Bool
    let error     : ErrorResponse?
}

struct CountryResponse: Codable {
    let code      : String
    let name      : String
}
