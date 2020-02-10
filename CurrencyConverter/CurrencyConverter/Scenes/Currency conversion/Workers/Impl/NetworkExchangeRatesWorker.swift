//
//  NetworkExchangeRatesWorker.swift
//  CurrencyConverter
//
//  Created by Tiago Chaves on 10/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//

import Foundation

final class NetworkExchangeRatesWorker<T: DataManager>: ExchangeRatesWorkerProtocol where T.T == Data {
    var dataManager: T
    
    init(dataManager: T) {
        self.dataManager = dataManager
    }
    
    func getExchangeRates(completion: @escaping (ExchangesRates?, Error?) -> ()) {
        dataManager.request(.getExchangeRates) { (data, error) in
            if error == nil,
                let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(ExchangesRates.self, from: data)
                    
                    completion(decodedData, nil)
                } catch {
                    completion(nil, NetworkExchangeRatesWorkerError.cannotDecodeData)
                }
            } else {
                completion(nil, NetworkExchangeRatesWorkerError.requestError)
            }
        }
    }
}

enum NetworkExchangeRatesWorkerError: Error {
    case cannotDecodeData
    case requestError
}
