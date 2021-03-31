//
//  CurrencyRepositoryProtocol.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 29/03/21.
//

protocol CurrencyRepositoryProtocol {
    
    // MARK: - Attributes
    var network: Networking { get }
    
    // MARK: - Methods
    func getCurrencyList(completion: @escaping(Result<CurrencyObject, Error>) -> Void)
    func getCurrenciesRate(completion: @escaping(Result<CurrencyRateObject, Error>) -> Void)
}

extension CurrencyRepositoryProtocol {

    // MARK: - Methods
    func getCurrencyList(completion: @escaping(Result<CurrencyObject, Error>) -> Void) {
        if Reachability.isConnectedToNetwork() {
            self.network.execute(requestProvider: Endpoint.currencies, completion: completion)
        } else {
            completion(.failure(StringsDictionary.checkInternetConnection))
        }
    }
    
    func getCurrenciesRate(completion: @escaping(Result<CurrencyRateObject, Error>) -> Void) {
        if Reachability.isConnectedToNetwork() {
            self.network.execute(requestProvider: Endpoint.currencyRate, completion: completion)
        } else {
            completion(.failure(StringsDictionary.checkInternetConnection))
        }
    }
}
