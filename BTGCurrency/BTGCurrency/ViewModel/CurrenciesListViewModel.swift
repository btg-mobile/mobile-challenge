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
    
    func goToExchange(localCurrency: Currency, foreignCurrency: Currency) {
        Router.shared.setViewController(viewController: ExchangeViewController(localCurrency: localCurrency, foreignCurrency: foreignCurrency))
    }
    
    func isSelectionValid(currenciesFromTableView: UITableView, currenciesToTableView: UITableView) -> Bool {
        if let _ = currenciesFromTableView.indexPathForSelectedRow {
            if let _ = currenciesToTableView.indexPathForSelectedRow {
                return true
            } else {
                alert(title: "Atenção!", message: "Selecione a moeda para que deseja converter")
                return false
            }
        } else {
            alert(title: "Atenção!", message: "Selecione a moeda de origem")
            return false
        }
    }
}
