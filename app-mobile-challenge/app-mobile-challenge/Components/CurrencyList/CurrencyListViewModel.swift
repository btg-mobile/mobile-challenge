//
//  CurrencyListViewModel.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

final class CurrencyListViewModel {
    
    private var currencies: Currencies
    
    /// Descreve as moedas favoritas.
    private var favoriteCurrencies: Currencies {
        return currencies.filter({$0.favorite == true})
    }
    /// Descreve todas as moedas.
    private var allCurrencies: Currencies {
        return currencies
    }
    
    init(currencies: Currencies) {
        self.currencies = currencies
    }
    
    public func elementsBy(section: Int) -> Currencies {
        if (section == 0) { return favoriteCurrencies }
        else { return allCurrencies }
    }
    
    public func title(section: Int) -> String {
        switch section {
        case 0:
            return favoriteCurrencies.count > 0 ? "Favoritas" : ""
        default:
            return "Todas as moedas"
        }
    }
}
