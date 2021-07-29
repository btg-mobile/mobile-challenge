//
//  ChooseCurrencyViewModelProtocol.swift
//  Coin Converter
//
//  Created by Igor Custodio on 28/07/21.
//

import Foundation

protocol ChooseCurrencyViewModelProtocol {
    
    func getCurrencies(_ filter: String?) -> [Currency]
}
