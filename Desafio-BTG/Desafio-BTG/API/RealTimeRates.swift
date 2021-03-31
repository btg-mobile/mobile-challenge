//
//  RealTimeRatesApi.swift
//  Desafio-BTG
//
//  Created by Euclides Medeiros on 31/03/21.
//

import Foundation

protocol RealTimeRatesApiProtocol {
    func fetch(completion: @escaping (Int?, _ details: RealTimeRates?) -> Swift.Void)
}

class RealTimeRatesApi: RealTimeRatesApiProtocol {
    
    enum BaseUrl {
        static let urlRealTimeRates = "http://api.currencylayer.com/live?access_key=27b8bc6d2b73c0969fd137013349c926"
    }
    
    private let connectionManager: ConnectionManager
    
    init(connectionManager: ConnectionManager = ConnectionManager()) {
        self.connectionManager = connectionManager
    }
    
    func fetch(completion: @escaping (Int?, _ details: RealTimeRates?) -> Swift.Void)  {
        connectionManager.request(url:  BaseUrl.urlRealTimeRates, method: .get, parameters: nil, headers: nil) { (statusCode, details: RealTimeRates?) in
            completion(statusCode, details)
        }
    }

}
