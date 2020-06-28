//
//  CurrencyLayerService.swift
//  Coin Converter
//
//  Created by Jeferson Hideaki Takumi on 28/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

import Foundation

protocol CurrencyLayerServiceProtocol {
    func requestCurrencies(completion: @escaping ([CurrencyModel]?, Error?) -> Void)
    func requestQuotes(completion: @escaping ([QuoteModel]?, Error?) -> Void)
}

class CurrencyLayerService {
    
    let networkService: NetworkService = NetworkService()
    
    func requestCurrencies(completion: @escaping ([CurrencyModel]?, Error?) -> Void) {
        let endPoint: Endpoint.CurrencyLayer = Endpoint.CurrencyLayer.list
        
        networkService.request(model: CurrenciesContainerModel.self, endpoint: endPoint) { result in
            switch result {
            case .success(let container):
                if container.success {
                    completion(container.currencies, nil)
                } else {
                    let error: Error = NSError(domain: #file, code: -1, userInfo:  [NSLocalizedDescriptionKey: "Não foi possível ler os dados."])
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func requestQuotes(completion: @escaping ([QuoteModel]?, Error?) -> Void) {
        let endPoint: Endpoint.CurrencyLayer = Endpoint.CurrencyLayer.live
        
        networkService.request(model: QuotesContainerModel.self, endpoint: endPoint) { result in
            switch result {
            case .success(let container):
                if container.success {
                    completion(container.quotes, nil)
                } else {
                    let error: Error = NSError(domain: #file, code: -1, userInfo:  [NSLocalizedDescriptionKey: "Não foi possível ler os dados."])
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
}
