//
//  CurrenciesList.swift
//  CurrencyConverterBTG
//
//  Created by Silvia Florido on 21/06/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation

class CurrenciesList: NSObject {
    let currencies: [Currency]
    
    init(currencies: [Currency]) {
        self.currencies = currencies
    }
    
    convenience init(with response: CurrenciesListResponse) {
        var currencies = response.currencies.map { (key, value) -> Currency in
            return Currency(code: key, name: value)
        }
        currencies.sort{ $0.code.uppercased() < $1.code.uppercased() }
        self.init(currencies: currencies)
    }
    
    func getCurrency(fromCode: String) -> Currency? {
        return currencies.first{ $0.code == fromCode }
    }
    
    func getDefaultCurrencies() -> [Currency]? {
        guard currencies.count > 1 else {
            return nil
        }
        
        let defaultCurrencies = ["BRL", "USD", "EUR", "GBP"]
        
        return defaultCurrencies.compactMap { (currencyCode) -> Currency? in
            return getCurrency(fromCode: currencyCode)
        }
    }
    
}
