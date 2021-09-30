//
//  Quotation.swift
//  CurrencyConverter
//
//  Created by Eduardo Lopes on 29/09/21.
//

import Foundation

struct Quotation: Codable {
    let success: Bool
    let source: String
    let quotes: [String: Double]
}
