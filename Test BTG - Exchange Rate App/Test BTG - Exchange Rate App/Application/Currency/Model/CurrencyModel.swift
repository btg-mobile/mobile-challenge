//
//  CurrencyModel.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 01/03/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import Foundation

class CurrencyModel: Codable {
    var initials: String = ""
    var name: String = ""
    var value: Double = 0.0
    
    init(initials: String, name: String, value: Double) {
        self.initials = initials
        self.name = name
        self.value = value
    }
}
