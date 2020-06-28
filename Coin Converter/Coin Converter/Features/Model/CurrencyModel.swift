//
//  CurrencyModel.swift
//  Coin Converter
//
//  Created by Jeferson Hideaki Takumi on 28/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

struct CurrencyModel: Decodable {
    let symbol: String
    let descriptionCurrency: String
}

extension CurrencyModel: CustomStringConvertible {
    
    var description: String {
        return "\(symbol.uppercased()) / \(descriptionCurrency)"
    }
}
