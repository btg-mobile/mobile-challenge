//
//  LiveQuotesResponse.swift
//  CurrencyConverterBTG
//
//  Created by Silvia Florido on 20/06/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation

class LiveQuotesResponse: Decodable {
    
    let success: Bool
    let terms: String
    let privacy: String
    let timestamp: UInt64
    let source: String
    let quotes: Dictionary<String,Double>
    
    
}
