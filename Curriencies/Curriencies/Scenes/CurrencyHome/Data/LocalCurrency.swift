//
//  LocalCurrency.swift
//  Curriencies
//
//  Created by Ferraz on 03/09/21.
//

protocol LocalCurrencyProtocol {
    func getCurrency(completion: @escaping(Result<[CurrencyEntity], RepositoryError>) -> Void)
    func saveCurrency(currencies: [CurrencyEntity])
}

struct LocalCurrency: LocalCurrencyProtocol {
    func getCurrency(completion: @escaping (Result<[CurrencyEntity], RepositoryError>) -> Void) {
        
    }
    
    func saveCurrency(currencies: [CurrencyEntity]) {
        
    }
}
