//
//  CurrencieModel.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 10/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Foundation

class CurrencieModel {
    let name: String
    let nameFull: String
    let quote: Double

    init(name: String = "", nameFull: String = "", quote: Double = 0) {
        self.name = name
        self.nameFull = nameFull
        self.quote = quote
    }
}
