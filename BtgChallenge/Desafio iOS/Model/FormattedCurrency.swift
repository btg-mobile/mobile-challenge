//
//  CurrencyList.swift
//  Desafio iOS
//
//  Created by Lucas Soares on 29/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import Foundation
class FormattedCurrency {
    var currencyCode: String
    var currencyFullName: String
    
    init(currencyCode: String, currencyName: String) {
        self.currencyCode = currencyCode
        self.currencyFullName = currencyName
    }
}
