//
//  SupportedCurrenciesViewModel.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 03/10/20.
//

import Foundation

final class SupportedCurrenciesViewModel {

    private var currencies: [[Currency]] = [[Currency]]()

    init(currencies: ListCurrencyResponse) {
        self.currencies = convert(from: currencies)
    }

    /// The number of sections to be displayed in the `View`.
    var numberOfSections: Int {
        return currencies.count
    }

    /// Returns the number of rows to be displayed in a given section.
    /// - Parameter section: The section in the `View`.
    func numberOfRows(in section: Int) -> Int {
        return currencies[section].count
    }

    /// Returns a currency's code at a given `IndexPath`.
    /// - Parameter index: The `IndexPath` of a currency.
    func currencyCodeAt(index: IndexPath) -> String {
        return currencies[index.section][index.row].code
    }

    /// Returns a currency's name at a given `IndexPath`.
    /// - Parameter index: The `IndexPath` of a currency.
    func nameCodeAt(index: IndexPath) -> String {
        return currencies[index.section][index.row].name
    }

    private func convert(from response: ListCurrencyResponse) -> [[Currency]] {
        let currencies = response.currencies.keys.map { Currency(code: $0, name: response.currencies[$0] ?? "") }
        let sortedCurrencies = currencies.sorted(by: { $0.code < $1.code })

        let result = [sortedCurrencies]

        return result
    }
}
