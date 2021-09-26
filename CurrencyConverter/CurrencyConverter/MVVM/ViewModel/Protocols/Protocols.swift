//
//  Protocols.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu on 25/09/21.
//

import Foundation

// MARK: -  Main ViewModel
protocol ViewModelProtocol: ConversionViewModel, CurrencyListViewModel {}

// MARK: - Conversion ViewModel
protocol ConversionViewModel: AnyObject {
    var conversionDelegate: ConversionViewModelDelegate? { get set }
    func onValueChange(value: Float)
}

protocol ConversionViewModelDelegate: AnyObject {
    func convertedValueDidChange(value: Float)
    func initialCurrencyDidChange(currency: String)
    func finalCurrencyDidChange(currency: String)
}

// MARK: -  CurrencyList ViewModel
protocol CurrencyListViewModel: AnyObject {
    var currencyListDelegate: CurrencyListViewModelDelegate? { get set }
    func onSelect(currency: String, isInitial: Bool)
    func getCurrencyName(index: Int) -> String?
    func getCurrencyInitials(index: Int) -> String?
    func currenciesCount() -> Int?
    func onLoad()
    func setCurrency(currency: String, isInitial: Bool)
}

protocol CurrencyListViewModelDelegate: AnyObject {
    func didSelectCurrency()
    func didFetchCurrencies()
    func didFailToFetchCurrencies()
}

