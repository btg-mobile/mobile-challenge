//
//  ListCurrenciesModel.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 20/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import Foundation

class ListCurrenciesModel: NSObject {
    var name = String()
    var currency = String()
    
    init(name: String, currency: String) {
        self.name = name
        self.currency = currency
    }
}
