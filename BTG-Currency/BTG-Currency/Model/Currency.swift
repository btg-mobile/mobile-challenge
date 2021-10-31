//
//  Currency.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 27/10/21.
//

import Foundation

public struct Currency {
    public var value: Decimal
    public var symbol: String
    
    public init(value: Decimal = 0.0, symbol: String) {
        self.value = value
        self.symbol = symbol
    }
}
