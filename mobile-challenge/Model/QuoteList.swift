//
//  QuotesList.swift
//  mobile-challenge
//
//  Created by Brunno Andrade on 05/10/20.
//

import Foundation

struct QuotesList: Codable {
    let success: Bool
    let error: ErrorApi?
    let source: String?
    let currencies: [String: String]?
}
