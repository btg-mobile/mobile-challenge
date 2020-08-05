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
    
    func getNumberOfRowsInSection() -> Int {
        return currencies.count
    }
    
    func getCurrency(at index: Int) -> Currency {
        return currencies[index]
    }
}
