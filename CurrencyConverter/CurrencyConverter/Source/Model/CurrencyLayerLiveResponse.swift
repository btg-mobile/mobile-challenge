//
//  CurrencyLayerLiveResponse.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 13/12/20.
//

struct CurrencyLayerLiveResponse {
    
    let success: Bool
    let timestamp: Int
    let source: String
    let quotes: [String: Double]
    
}
