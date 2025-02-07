//
//  CurrencyViewModel.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 04/02/25.
//

import Foundation

class CurrencyViewModel {
    var currency: [(String, String)]?
    let currencyManager: CurrencyManager
    let storage: CurrencyStorage
    let monitor: NetworkMonitor
    
    init(currency: [(String, String)]? = nil, currencyManager: CurrencyManager, storage: CurrencyStorage, monitor: NetworkMonitor) {
        self.currency = currency
        self.currencyManager = currencyManager
        self.storage = storage
        self.monitor = monitor
    }
    
    func getCurrencyData() async throws -> [(String, String)] {
        if monitor.checkConnection() {
            let currencyResponse = try await currencyManager.fetchRequest()
            currency = currencyResponse.currencies.map { ($0.key, $0.value) }
            if !UserDefaults.standard.bool(forKey: "currency data salved") {
                storage.saveCurrency(currencyResponse: currency ?? [])
                UserDefaults.standard.setValue(true, forKey: "currency data salved")
            }
            return currency ?? []
        } else {
            let currencyStorage = storage.fetchCurrency()
            let currencytupla = currencyStorage.map { ($0.key ?? "", $0.value ?? "")}
            currency = currencytupla
            return currency ?? []
        }
    }
//
    func filterCurrency(searchBarText: String) -> [(String, String)] {
        if searchBarText.isEmpty {
            if let currency = currency {
                return currency
            }
        } else {
            let filteredCurrency = currency?.filter { (key,value) in
                key.lowercased().contains(searchBarText.lowercased()) || value.lowercased().contains(searchBarText.lowercased())
            }
            return filteredCurrency ?? []
        }
        return []
    }
    

    
    
}
