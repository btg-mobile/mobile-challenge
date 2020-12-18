//
//  Quote.swift
//  CurrencyChallenge
//
//  Created by Higor Chaves Peres on 17/12/20.
//

import Foundation

struct Quote{
    let name: String
    let value: Double
    
    init(name: String, value: Double){
        self.name = name
        self.value = value
    }
    
    init() {
        self.name = ""
        self.value = 0
    }
    
}
