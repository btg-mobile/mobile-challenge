//
//  CurrencyModel.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 01/03/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import Foundation

class CurrencyModel: Codable {
    var code: String = ""
    var name: String = ""
    var value: Decimal = 0.0
    
    init(code: String, name: String, value: Decimal) {
        self.code = code
        self.name = name
        self.value = value
    }
}
