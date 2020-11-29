//
//  CurrencyListViewModel.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

final class CurrencyListViewModel {
    
    private var currencies: Currencies
    private var textSearched: String = ""
    private var filtedCurrencies: Currencies {
        get {
            textSearched.isEmpty
                    ? currencies
                    : currencies.filter {
                    $0.name.range(of: textSearched, options: .caseInsensitive) != nil
            }
        } set {
            
        }
     }
    
    /// Descreve as moedas favoritas.
    private var favoriteCurrencies: Currencies {
        filtedCurrencies.filter({$0.favorite})
    }
    /// Descreve todas as moedas.
    private var allCurrencies: Currencies {
        filtedCurrencies.filter({!$0.favorite})
    }
    
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
        var name = ""
        //salvar a atualização
        if indexPath.section == 0 {
            name = favoriteCurrencies[indexPath.row].name
        } else {
            name = allCurrencies[indexPath.row].name
        }
        guard let index = currencies.firstIndex(where: {$0.name==name}) else { return }
        currencies[index].favorite.toggle()
        recalculate()
    }
    
    private func recalculate() {
        filtedCurrencies = currencies
    }
    
    public func filterBy(textSearched: String) {
        self.textSearched = textSearched
        recalculate()
    }
}
