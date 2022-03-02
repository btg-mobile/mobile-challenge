//
//  ExchangeRateViewModel.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 02/03/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import Foundation

// MARK: - Protocol

protocol ExchangeRateViewModelProtocol {
    
    // MARK: - Methods
    
    func getData()
}

// MARK: - Class

class ExchangeRateViewModel: ExchangeRateViewModelProtocol {
    
    // MARK: - Properties
    
    private var exchangeRatesVO: ExchangeRateVO?
    private var currenciesVO: CurrenciesVO?
    private var currenciesList: [CurrencyModel] = []
    
    // MARK: - Init's
    
    init() {
    }
    
    // MARK: - Methods
    
    func getData() {
        //  Exchange Rate
        NetworkManager.shared.getExchange { success, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let response = response, success else { return }
            self.exchangeRatesVO = response
            
        }
        
        //  Curencies
        NetworkManager.shared.getCurrencies { success, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let response = response, success else { return }
            self.currenciesVO = response
            
            self.concatenateValues()
        }
        
    }
    
    private func concatenateValues() {
        
        guard let exchangeVO = exchangeRatesVO, let currenciesVO = currenciesVO else {
            return
        }
        
        let currenciesList: [CurrencyModel] = exchangeVO.quotes.compactMap({ quote in
            let initials = quote.key.replacingOccurrences(of: "USD", with: "")
            let currency = CurrencyModel(initials: initials, name: currenciesVO.currencies[initials] ?? "", value: quote.value)
            
            return currency
        })
        
        self.currenciesList = currenciesList
    }
}
