//
//  ConverterModel.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import Foundation

struct ConverterLiveResponse: Decodable {
    let success: Bool
    let source: String
    let quotes: [String:Double]
}
