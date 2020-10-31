//
//  ExchangeViewModel.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import Foundation

final class ExchangeViewModel {
    
    var originCurrency: Currency?
    var destinationCurrency: Currency?
    
    init() {
        
    }
    
    func validateCurrency(){
        
    }
    
    func converter(){
        
        guard let originCurrency = self.originCurrency, let destinationCurrency = self.destinationCurrency else {
            return
        }
        
        let currencyClient = CurrencyClient(session: URLSession.shared)
        currencyClient.getLiveCurrenciesByNames(origin: originCurrency.code, destination: destinationCurrency.code) { (result) in
            
            switch result {
            
            case .success(let currencies):
                print("DEBUG: Currencies - ",currencies)
            case .failure(let error):
                print("Error in converter - ",error)
            }
        }
    }
}
