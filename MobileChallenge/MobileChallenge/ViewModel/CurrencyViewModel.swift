//
//  CurrencyViewModel.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 04/02/25.
//

import Foundation


class CurrencyViewModel {
    var currency: CurrencyResponse?
    let currencyManager: CurrencyManager

    
    init(currencyManager: CurrencyManager) {
        self.currencyManager = currencyManager
    }
    
    func getCurrencyData() async throws -> CurrencyResponse {
        currency = try await currencyManager.fetchRequest()
        return currency ?? CurrencyResponse(currencies: [:])
    }
    
    func filterCurrency(searchBarText: String) -> CurrencyResponse {
        if searchBarText.isEmpty {
            if let currency = currency {
                return currency
            }
        } else {
            let filteredCurrency = currency?.currencies.filter { (key,value) in
                key.lowercased().contains(searchBarText.lowercased()) || value.lowercased().contains(searchBarText.lowercased())
            }
            return CurrencyResponse(currencies: filteredCurrency ?? [:])
        }
        return CurrencyResponse(currencies: [:])
    }
    
}
