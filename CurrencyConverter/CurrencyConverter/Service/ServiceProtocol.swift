//
//  Service.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu on 25/09/21.
//

import Foundation

protocol ServiceProtocol {
    typealias CurrenciesResult = Result<Currencies, ServiceError>
    func fetchCurrencyList(completion: @escaping (CurrenciesResult) -> Void)
    func fetchQuotationLive(completion: @escaping (Result<QuotationLive,ServiceError>) -> Void)
}

class ServiceDefault: ServiceProtocol {
    
    var networkDispatcher: NetworkDispatcherProtocol = NetworkDispatcher()
    
    private func dispatchCompletion(completion: @escaping (CurrenciesResult) -> Void, result: CurrenciesResult) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
    
    func fetchCurrencyList(completion: @escaping (CurrenciesResult) -> Void) {
        networkDispatcher.request(endpoint: .list) { result in
            switch result {
            case .success(let data):
                do {
                    let list = try JSONDecoder().decode(Currencies.self, from: data)
                    self.dispatchCompletion(completion: completion, result: .success(list))
                } catch {
                    self.dispatchCompletion(completion: completion, result: .failure(.parseError))
                }
            
            case .failure(let err):
                self.dispatchCompletion(completion: completion, result: .failure(ServiceError.networkError(err.localizedDescription)))
            }
        }
    }
    
    func fetchQuotationLive(completion: @escaping (Result<QuotationLive, ServiceError>) -> Void) {
        networkDispatcher.request(endpoint: .live) { result in
            switch result {
            case .success(let data):
                do {
                    let cotation = try JSONDecoder().decode(QuotationLive.self, from: data)
                    completion(.success(cotation))
                } catch {
                    completion(.failure(ServiceError.parseError))
                }
            
            case .failure(let err):
                completion(.failure(ServiceError.networkError(err.localizedDescription)))
            }
        }
    }
}
