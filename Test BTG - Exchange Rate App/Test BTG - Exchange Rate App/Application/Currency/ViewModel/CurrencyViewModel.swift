//
//  CurrencyViewModel.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 01/03/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import Foundation

// MARK: - Protocol

protocol CurrencyViewModelProtocol {
    
    // MARK: - Properties
    
    var lisCurrencies:  Bindable<[CurrencyModel]>    { get }
    var isUpdateTable:  Bindable<Bool>               { get }
    
    // MARK: - Methods
    
    func setList(_ lisCurrencies: [CurrencyModel]?)
}

// MARK: - Class

class CurrencyViewModel {
    
    // MARK: - Properties
    
    public var listCurrencies: Bindable<[CurrencyModel]>
    public var isUpdateTable: Bindable<Bool>
    
    private var currencyList: [CurrencyModel]?
    
    // MARK: - Init's
    
    init() {
        isUpdateTable   = Bindable<Bool>()
        listCurrencies  = Bindable<[CurrencyModel]>()
    }
    
    // MARK: - Methods
    
    func setList(_ listCurrencies: [CurrencyModel]?) {
        currencyList = listCurrencies?.sorted(by: { $0.code < $1.code}) ?? []
        self.listCurrencies.value = currencyList
    }
}
