//
//  Currency.swift
//  mobileChallenge
//
//  Created by Henrique on 03/02/25.
//

import Foundation

struct CurrencyName: Codable {
    let code: String
    let name: String
}

struct Currency: Codable {
    let currencies: [String: String]
}
