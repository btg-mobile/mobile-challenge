//
//  QuotesModel.swift
//  Coin Converter
//
//  Created by Jeferson Hideaki Takumi on 27/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

struct QuotesModel: Codable {
    let success: Bool
    let terms: String
    let privacy: String
    let timestamp: Int
    let source: String
    let quotes: [String: Double]
}
