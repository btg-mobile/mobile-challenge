//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 30/10/20.
//

import Foundation
import CurrencyServices

class Currecy {
    let code: String
    let name: String
    
    init(code: String, name: String) throws {
        self.code = code
        self.name = name
    }
}
