//
//  Currency.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import Foundation

struct Currency {
    let code: String
    let name: String
    var favorite: Bool = false
}

typealias Currencies = [Currency]

extension Currencies {
    static let sample = [
        Currency(code: "USD", name: "US Dollar"),
        Currency(code: "CHF", name: "Swiss Franc"),
        Currency(code: "JPY", name: "Japanese Yen"),
        Currency(code: "GBP", name: "British Pound")
    ]
}
