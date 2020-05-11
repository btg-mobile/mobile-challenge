//
//  TaxResponse.swift
//  BTG Converser
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//


class TaxResponse: Codable {

    let success: Bool
    let terms: String
    let privacy: String
    let timestamp: Int
    let source: String
    let quotes: [String : Double]

}
