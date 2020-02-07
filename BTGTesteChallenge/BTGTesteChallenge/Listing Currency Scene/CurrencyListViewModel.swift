//
//  CurrencyListViewModel.swift
//  BTGTesteChallenge
//
//  Created by Rafael  Hieda on 2/6/20.
//  Copyright © 2020 Rafael_Hieda. All rights reserved.
//

import Foundation

protocol ListOfCurrencyViewModelProtocol: class {
    var listCurrencyRepository: ListCurrencyRepositoryProtocol? { get }
    var currencyListKey: [String] { get }
    var currencyListValue: [String] { get }
    var currencyDictionary: [String : String] { get set }
    var delegate: PresentErrorDelegate { get }
    func totalOfCurrencies() -> Int
    func requestCurrencyList()
    
}

class ListOfCurrencyViewModel: ListOfCurrencyViewModelProtocol {
    
    var currencyDictionary: [String : String] = [:]
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
    
    var delegate: PresentErrorDelegate
    
    weak var listCurrencyRepository: ListCurrencyRepositoryProtocol?

    init(listCurrencyRepository: ListCurrencyRepositoryProtocol, presentErrorDelegate: PresentErrorDelegate) {
        self.listCurrencyRepository = listCurrencyRepository
        self.delegate = presentErrorDelegate
    }
    
    func totalOfCurrencies() -> Int {
        return currencyDictionary.count
    }
        
    func requestCurrencyList() {
        listCurrencyRepository?.fetchListOfCurrency(completionHandler: { [weak self] (result) in
            switch result {
            case .success(let currencyList):
                guard let currencies = currencyList.currencies else { return }
                self?.currencyDictionary = currencies
            case .error(let error):
                self?.delegate.present(error: error.localizedDescription)
            }
        })
    }

}
