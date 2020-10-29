//
//  ListNetwork.swift
//  CurrencyServices
//
//  Created by Breno Aquino on 29/10/20.
//

import Foundation

public class CurrencylayerNetwork {
    
    private let baseUrl: String = "api.currencylayer.com"
    private let accessKey: String = "ef06b891def0317f86b874f22acf7852"
    
    public func list(callback: @escaping (Result<Dictionary<String, String>, NSError>) -> Void) {
        Network.request(method: .get, baseUrl: baseUrl, path: "/list", params: ["access_key": accessKey]) { result in
            switch result {
            case .success(let dict):
                if let currencies = dict["currencies"] as? [String: String] {
                    callback(.success(currencies))
                } else {
                    callback(.failure(NSError()))
                }
                
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
}
