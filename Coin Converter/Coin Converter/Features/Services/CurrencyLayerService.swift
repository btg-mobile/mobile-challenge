//
//  CurrencyLayerService.swift
//  Coin Converter
//
//  Created by Jeferson Hideaki Takumi on 28/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

import Foundation

/// protocol responsible for implementing calls from the Currency Layer
protocol CurrencyLayerServiceProtocol {
    
    /// request the currencies
    func requestCurrencies(completion: @escaping ([CurrencyModel]?, Error?) -> Void)
    
    /// request the quotes
    func requestQuotes(completion: @escaping ([QuoteModel]?, Error?) -> Void)
}

class CurrencyLayerService: CurrencyLayerServiceProtocol {
    
    let networkService: NetworkService = NetworkService()
    
    func requestCurrencies(completion: @escaping ([CurrencyModel]?, Error?) -> Void) {
        let endPoint: Endpoint.CurrencyLayer = Endpoint.CurrencyLayer.list
        
        networkService.request(model: CurrenciesContainerModel.self, endpoint: endPoint) { result in
            switch result {
            case .success(let container):
                if container.success {
                    //TODO: implement save data base
                    completion(container.currencies, nil)
                } else {
                    
                    if let errorModel: ErrorModel = container.error {
                        //TODO: Implement register log
                        print(errorModel.info)
                    }
                    
                    let error: Error = NSError(domain: #file, code: -1, userInfo:  [NSLocalizedDescriptionKey: "The data could not be read."])
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
                    //TODO: implement save data base
                    completion(container.quotes, nil)
                } else {
                    
                    if let errorModel: ErrorModel = container.error {
                        //TODO: Implement register log
                        print(errorModel.info)
                    }
                    
                    let error: Error = NSError(domain: #file, code: -1, userInfo:  [NSLocalizedDescriptionKey: "The data could not be read."])
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
}
