//
//  Currency.swift
//  CurrencyChallenge
//
//  Created by Higor Chaves Peres on 16/12/20.
//

import Foundation

public struct Currency {
    
    public let abbreviation: String
    public let fullName: String
    
    public init(abbreviation: String, fullName: String) {
        self.abbreviation = abbreviation
        self.fullName = fullName
    }
}
