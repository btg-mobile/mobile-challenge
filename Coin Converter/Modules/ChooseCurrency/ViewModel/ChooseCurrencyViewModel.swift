//
//  ChooseCurrencyViewModel.swift
//  Coin Converter
//
//  Created by Igor Custodio on 28/07/21.
//

import Foundation

class ChooseCurrencyViewModel: ChooseCurrencyViewModelProtocol {
    
    private var currencies: [Currency] = []
    
    init(currencies: [Currency]) {
        self.currencies = currencies
    }
    
    func getCurrencies(_ filter: String? = nil) -> [Currency] {
        if let filter = filter?.lowercased().trimmingCharacters(in: .whitespaces) {
            return currencies.filter { $0.initials.lowercased().contains(filter) || $0.extendedName.lowercased().contains(filter) }
        }
        
        return currencies
    }
}
