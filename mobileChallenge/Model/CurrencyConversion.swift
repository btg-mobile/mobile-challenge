//
//  CurrencyConversion.swift
//  mobileChallenge
//
//  Created by Henrique on 03/02/25.
//

import Foundation

struct CurrencyConversion: Codable {
    let quotes: [String: Double]
}

struct CurrencyConversionName: Codable {
    let code: String
    let value: Double
}


