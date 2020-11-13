//
//  CurrencyConversionResponse.swift
//  CurrencyConversor
//
//  Created by Erick Mitsugui Yamato on 12/11/20.
//

import Foundation

struct CurrencyConversionResponse: Codable {
    let result : Double?
    let success: Bool
    let error  : ErrorResponse?
}
