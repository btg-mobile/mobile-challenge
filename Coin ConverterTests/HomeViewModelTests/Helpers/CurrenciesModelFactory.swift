//
//  CurrenciesModelFactory.swift
//  Coin ConverterTests
//
//  Created by Igor Custodio on 29/07/21.
//

import Foundation
@testable import Coin_Converter

func makeCurrency(initials: String = "USD", extendedName: String = "United States Dollar") -> Currency {
    return Currency(initials: "USD", extendedName: extendedName)
}

func makeCurrencies() -> [Currency] {
    return [
        makeCurrency(),
        makeCurrency(initials: "BRL", extendedName: "Brazilian Real")
    ]
}
