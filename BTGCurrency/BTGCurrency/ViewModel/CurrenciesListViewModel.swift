//
//  CurrenciesViewModel.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 02/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import Foundation
import RealmSwift

class CurrenciesListViewModel {
    fileprivate let currencies: Results<Currency>
    
    init() {
        currencies = CurrencyData.getAll()
    }
    
    func getNumberOfRowsInSection(search: String?) -> Int {
        var _currencies = currencies
        if let search = search {
            _currencies = currencies.filter("name LIKE[c] %@ OR abbreviation LIKE[c] %@", "*\(search)*", "*\(search)*")
        }
        return _currencies.count
    }
    
    func getCurrency(at index: Int, search: String?) -> Currency {
        var _currencies = currencies
        if let search = search {
            _currencies = currencies.filter("name LIKE[c] %@ OR abbreviation LIKE[c] %@", "*\(search)*", "*\(search)*")
        }
        return _currencies[index]
    }
}
