//
//  CurrencyStorage.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 06/02/25.
//

import Foundation
import CoreData

class CurrencyStorage {
    
    let dataManagerContext = DataManager.shared
    
    func saveCurrency(currencyResponse: [(String, String)]) {
        for (key, value) in currencyResponse {
            let currency = Currency(context: dataManagerContext.context)
            currency.key = key
            currency.value = value
        }
        
        dataManagerContext.saveContext()
    }
    
    func fetchCurrency() -> [Currency] {
        let fetchRequest: NSFetchRequest<Currency>
        fetchRequest = Currency.fetchRequest()
        
        do {
            let currencies = try dataManagerContext.context.fetch(fetchRequest)
            return currencies
        } catch {
            print("error to fetch currencies")
            return []
        }
    }
    
    
}


