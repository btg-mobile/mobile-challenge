//
//  CurrencyAPI.swift
//  mobile-challenge
//
//  Created by Brunno Andrade on 04/10/20.
//

import Foundation

protocol CurrencyAPIProtocol {
    func fetchCurrencyList(callback: @escaping (Result<CurrencyList>) -> Void)
}

class CurrencyAPI {
    
    static var shared: CurrencyAPI = CurrencyAPI()
    let network = Network()
    
    private init() { }
    
}

extension CurrencyAPI {
    
    func fetchCurrencyList(callback: @escaping (Result<CurrencyList>) -> Void)  {
        
        let url = getURL(path: "list")
        
        self.network.request(url: url, method: .get, callback: callback)
    }
    
    private func getURL(path: String) -> String {
        return "\(Constraints.URI.rawValue)/\(path)?access_key=\(Constraints.acessKey.rawValue)"
    }
}
