//
//  ErrorResponse.swift
//  CurrencyConversor
//
//  Created by Erick Mitsugui Yamato on 09/11/20.
//

import Foundation

struct ErrorResponse: Codable {
    let code : Int
    let info : String
}
