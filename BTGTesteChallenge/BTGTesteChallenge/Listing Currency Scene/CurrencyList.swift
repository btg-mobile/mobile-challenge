//
//  CurrencyList.swift
//  BTGTesteChallenge
//
//  Created by Rafael  Hieda on 2/4/20.
//  Copyright © 2020 Rafael_Hieda. All rights reserved.
//

import Foundation

struct CurrencyList : Decodable {
    var success : Bool?
    var terms: String?
    var privacy: String?
    var currencies: [String:Double]?
}
