//
//  CurrencyListViewModel.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 27/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol CurrencyListViewModelProtocol {
    var currencyList: [CurrencyListModel] { get }
    var delegate: CurrencyListViewModelDelegate? { get set }
    
    func fetchCurrencies()
    func didSelectCurrency(id: String)
}

protocol CurrencyListViewModelDelegate: class {
    func didFetchSelectedCurrency(id: String)
    func didFetchCurrencies()
}

class CurrencyListViewModel: CurrencyListViewModelProtocol {
    
    private(set) var currencyList: [CurrencyListModel] = [] {
        didSet {
            
        }
    }
    
    weak var delegate: CurrencyListViewModelDelegate?
    
    func fetchCurrencies() {
        
    }
    
    func didSelectCurrency(id: String) {
        
    }
}
