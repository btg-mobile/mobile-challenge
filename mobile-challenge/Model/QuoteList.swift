//
//  QuoteList.swift
//  mobile-challenge
//
//  Created by Brunno Andrade on 05/10/20.
//

import Foundation

struct QuoteList: Codable {
    let success: Bool
    let error: ErrorApi?
    let source: String?
    let quotes: [String: Float]?
}
