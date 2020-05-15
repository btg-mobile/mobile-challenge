//
//  BTGCurrencyConverterVCController.swift
//  BTGConverterAPP
//
//  Created by Ana Caroline de Souza on 15/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import Foundation

protocol CurrencyConverterController {
     func getCurrencyConversion(base: String, target: String, value: Decimal) -> String
}

class BTGCurrencyConverterController: CurrencyConverterController {
    
    func getCurrencyConversion(base: String, target: String, value: Decimal) -> String {
        print("vamos lá")
        return "23432 USD"
    }
    
    
}


