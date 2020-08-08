//
//  Currencies.swift
//  BTGPactual-HelioVieira
//
//  Created by Helio Junior on 08/08/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import Foundation

protocol CurrenciesResponse: Decodable {
    var success: Bool {get}
}

struct Currencies: CurrenciesResponse {
    let success: Bool
    let currencies: [String:String]
}
