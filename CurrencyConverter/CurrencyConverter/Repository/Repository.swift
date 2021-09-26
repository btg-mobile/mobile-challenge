//
//  Repository.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu on 25/09/21.
//

import Foundation

protocol Repository {
    func fetchCurrencyList(completion: @escaping (Result<CurrencyList,RepositoryError>) -> Void)
    func fetchQuotationLive(completion: @escaping (Result<QuotationLive,RepositoryError>) -> Void)
}

class RepositoryDefault: Repository {
    
    var networkDispatcher: NetworkDispatcherProtocol = NetworkDispatcher()
    
    func fetchCurrencyList(completion: @escaping (Result<CurrencyList, RepositoryError>) -> Void) {
        networkDispatcher.request(endpoint: .list) { result in
            switch result {
            case .success(let data):
                do {
                    let list = try JSONDecoder().decode(CurrencyList.self, from: data)
                    completion(.success(list))
                } catch {
                    completion(.failure(RepositoryError.parseError))
                }
            
            case .failure(let err):
                completion(.failure(RepositoryError.networkError(err.localizedDescription)))
            }
        }
    }
    
    func fetchQuotationLive(completion: @escaping (Result<QuotationLive, RepositoryError>) -> Void) {
        networkDispatcher.request(endpoint: .live) { result in
            switch result {
            case .success(let data):
                do {
                    let cotation = try JSONDecoder().decode(QuotationLive.self, from: data)
                    completion(.success(cotation))
                } catch {
                    completion(.failure(RepositoryError.parseError))
                }
            
            case .failure(let err):
                completion(.failure(RepositoryError.networkError(err.localizedDescription)))
            }
        }
    }
}
