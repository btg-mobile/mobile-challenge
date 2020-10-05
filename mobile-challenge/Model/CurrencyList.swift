//
//  CurrencyList.swift
//  mobile-challenge
//
//  Created by Brunno Andrade on 04/10/20.
//

import Foundation

struct CurrencyList: Codable {
    let success: Bool
    let error: ErrorApi?
    let currencies: [String: String]?
}
