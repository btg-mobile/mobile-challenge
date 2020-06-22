//
//  Currency.swift
//  CurrencyConverterBTG
//
//  Created by Silvia Florido on 19/06/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation

class Currency: NSObject {
    
    let code: String
    let name: String
    
    init(code: String, name: String) {
        self.code = code
        self.name = name
    }
    
    static func == (lhs: Currency, rhs: Currency) -> Bool {
        return lhs.code == rhs.code
    }
    
}
