//
//  Currency.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 03/10/20.
//

import Foundation

struct Currency {
    let code: String
    let name: String
}

#if DEBUG
extension Currency {
    static func generate(_ amount: Int) -> [Currency] {
        return Array(repeating: Currency(code: "BRL", name: "Brazilian Real"), count: amount)
    }
}
#endif
