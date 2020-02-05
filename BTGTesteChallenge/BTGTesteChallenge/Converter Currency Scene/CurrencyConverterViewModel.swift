//
//  CurrencyConverterViewModel.swift
//  BTGTesteChallenge
//
//  Created by Rafael  Hieda on 2/5/20.
//  Copyright © 2020 Rafael_Hieda. All rights reserved.
//

import Foundation

protocol CurrencyConverterViewModelProtocol: class {
    var liveCurrencyRepository: LiveCurrencyRepositoryProtocol? { get }
    var listCurrencyRepository: ListCurrencyRepositoryProtocol? { get }
    var isSourceSelected: Bool {get set}
    var selectedSourceCurrency: String {get set}
    var selectedConversionCurrency: String {get set}
    var currencyListKey: [String] { get }
    var currencyListValue: [String] { get }
    
    func totalOfCurrenciesInList() -> Int
    func requestLoadData()
    func performConversion(value: String)
}

class CurrencyConverterViewModel: CurrencyConverterViewModelProtocol {
        
    weak var liveCurrencyRepository: LiveCurrencyRepositoryProtocol?
    weak var listCurrencyRepository: ListCurrencyRepositoryProtocol?
    var selectedSourceCurrency: String = "USD"
    var selectedConversionCurrency: String = "USDUSD"
    var currencyDictionary: [String : String] = [:]
    var currencyRatesDictionary: [String : Double] = [:]
    var isSourceSelected: Bool = false
    
    var currencyListKey: [String] {
        return currencyDictionary.map {
            $0.value
        }
    }
    
    var currencyListValue: [String] {
        return currencyDictionary.map {
            $0.key
        }
    }
    
    init(liveCurrencyRepository: LiveCurrencyRepositoryProtocol, listCurrencyRepository: ListCurrencyRepositoryProtocol) {
        self.liveCurrencyRepository = liveCurrencyRepository
        self.listCurrencyRepository = listCurrencyRepository
    }
    
    func totalOfCurrenciesInList() -> Int {
        return currencyListKey.count
    }
    
    func getCurrencyRate() -> Double {
        return currencyRatesDictionary["USD\(selectedSourceCurrency)"] ?? 0.00
    }
    
    func requestLoadData() {
        
    }
    
    func performConversion(value: String) {
        
    }

        
}
