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
    
}
