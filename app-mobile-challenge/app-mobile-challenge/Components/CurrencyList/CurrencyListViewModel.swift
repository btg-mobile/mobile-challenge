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
    private lazy var favoriteCurrencies = currencies.filter({$0.favorite})
    /// Descreve todas as moedas.
    private lazy var allCurrencies = currencies.filter({!$0.favorite})
    
    init(currencies: Currencies) {
        self.currencies = currencies
    }
    
    public func elementsBy(section: Int) -> Currencies {
        return section == 0 ? favoriteCurrencies : allCurrencies
    }
    
    public func title(section: Int) -> String {
        switch section {
        case 0:
            return favoriteCurrencies.count > 0 ? "Favoritas" : ""
        default:
            return allCurrencies.count > 0 ? "Todas as moedas" : ""
        }
    }
    
    public func toggleFavorite(indexPath: IndexPath) {
        //salvar a atualização
        if indexPath.section == 0 {
            favoriteCurrencies[indexPath.row].favorite.toggle()
        } else {
            allCurrencies[indexPath.row].favorite.toggle()
        }
        recalculate()
    }
    
    private func recalculate() {
        currencies = favoriteCurrencies + allCurrencies
        favoriteCurrencies = currencies.filter({$0.favorite})
        allCurrencies = currencies.filter({!$0.favorite})
    }
}
