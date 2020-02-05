//
//  ConvertCurrencyModel.swift
//  BTGTesteChallenge
//
//  Created by Rafael  Hieda on 2/4/20.
//  Copyright © 2020 Rafael_Hieda. All rights reserved.
//

import Foundation

struct CurrencyRate : Decodable {
    var success: Bool?
    var terms: String?
    var privacy: String?
    var timestamp: String?
    var source: String?
    var quotes: [String:Double]?
    var error: Error?
}
