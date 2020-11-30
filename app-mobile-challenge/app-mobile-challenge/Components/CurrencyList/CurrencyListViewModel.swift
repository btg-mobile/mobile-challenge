//
//  CurrencyListViewModel.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

/// `ViewModel` responsável pela `CurrencyList`.
final class CurrencyListViewModel {
    /// Lista de moedas.
    private var currencies: Lists
    /// Texto que define o que esta sendo pesquisado.
    private var textSearched: String = ""
    /// Filtro de pesquisa
    private var filtedCurrencies: Lists {
        get {
        textSearched.isEmpty
            ? currencies
            : currencies.filter {
            $0.name.range(of: textSearched, options: .caseInsensitive) != nil ||
            $0.code.range(of: textSearched, options: .caseInsensitive) != nil
        }} set {}
     }
    
    /// Descreve as moedas favoritas.
    private var favoriteCurrencies: Lists {
        filtedCurrencies.filter({$0.favorite})
    }
    /// Descreve todas as moedas.
    private var allCurrencies: Lists {
        filtedCurrencies.filter({!$0.favorite})
    }
    
    init(lists: Lists) {
        self.currencies = lists
    }
    
    /// Define qual lista de objetos está nos favoritos ou não.
    /// - Parameter section: número da sessão.
    /// - Returns: Lista correspondente a `section`
    public func elementsBy(section: Int) -> Lists {
        return section == 0 ? favoriteCurrencies : allCurrencies
    }
    
    /// Busca qual elemento se moeda está em um determinado `IndexPath`.
    /// - Parameter indexPath: valor correspondente ao index.
    /// - Returns: Retorna uma `List` que está em um determinado index.
    public func elementBy(indexPath: IndexPath) -> List {
        let section = indexPath.section
        let row = indexPath.row
        return section == 0 ?favoriteCurrencies[row]:allCurrencies[row]
    }
    
    /// Busca o título pelo número da sessão.
    /// - Parameter section: identificador da sessão.
    /// - Returns: Retorna o título da sessão caso haja objetos na lista correspondente, caso contrário, retorna uma `String` vazia.
    public func title(section: Int) -> String {
        switch section {
        case 0:
            return favoriteCurrencies.count > 0 ? "Favoritas" : ""
        default:
            return allCurrencies.count > 0 ? "Todas as moedas" : ""
        }
    }
    
    /// Identifica onde foi o toque nos favoritos salvando no `CommonData`.
    /// - Parameter indexPath: valor identificador da célula.
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
        currencies[index].saveFavorite()
        ImpactFeedback.run(style: .light)
        recalculate()
    }
    
    /// inicial novamente o valores do filtro.
    private func recalculate() {
        filtedCurrencies = currencies
    }
    
    /// Busca por um elemento na busca e recalcula os valores de filtro.
    /// - Parameter textSearched: texto a ser pesquisado.
    public func filterBy(textSearched: String) {
        self.textSearched = textSearched
        recalculate()
    }
    
    /// Busca no `CommonData` os favoritos e atualiza nas moedas locais.
    public func inicializeFavorites() {
        let favorites = CommonData.shared.favorites
        for favorite in favorites {
            if let index = currencies.firstIndex(where: { $0.code == favorite }) {
                currencies[index].favorite.toggle()
            }
        }
    }
}
