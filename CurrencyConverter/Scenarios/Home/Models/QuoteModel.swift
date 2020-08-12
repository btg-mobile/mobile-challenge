//
//  QuoteModel.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 10/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Foundation

class QuoteModel {
    let name: String
    let value: Double

    init(name: String, value: Double) {
        self.name = name
        self.value = value
    }
}
