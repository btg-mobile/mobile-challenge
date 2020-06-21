//
//  CurrenciesListResponse.swift
//  CurrencyConverterBTG
//
//  Created by Silvia Florido on 20/06/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation

class CurrenciesListResponse: Decodable {
    let success: Bool
    let terms: String
    let privacy: String
    let currencies: Dictionary<String,String>
}
