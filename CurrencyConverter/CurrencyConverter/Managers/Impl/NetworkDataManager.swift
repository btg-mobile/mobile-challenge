//
//  NetworkDataManager.swift
//  CurrencyConverter
//
//  Created by Tiago Chaves on 09/02/20.
//  Copyright (c) 2020 Tiago Chaves. All rights reserved.
//
//  This file was generated by Toledo's Swift Xcode Templates
//

import Foundation

struct NetworkDataManager: DataManager {
    
    func request(_ request: CurrencyConverterRequests, completion: @escaping (Data?, Error?) -> ()) {
        guard let url = request.url else {
            completion(nil, NetworkDataManagerError.cannotConvertStringToURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                if let data = data,
                    let response = response as? HTTPURLResponse,
                    (200...299).contains(response.statusCode) {
                    
                    completion(data, nil)
                } else {
                    completion(nil, NetworkDataManagerError.requestError)
                }
            }else{
                completion(nil, error)
            }
        }.resume()
    }
}

enum NetworkDataManagerError: Error {
    case cannotConvertStringToURL
    case requestError
}

extension CurrencyConverterRequests {
    static let baseURL = "http://api.currencylayer.com"
    #error("Para compilar de forma correta você deve criar, no projeto, um Swift File conforme exemplo abaixo ou colocar um chave válida na constante accessKey. Após realizar uma das duas ações, comente ou apague esse #error e compile novamente. :)")
    /*
     //Exemplo do arquivo necessário com uma access key válida
     struct AccessKey {
     static let accessKey = "Uma access key válida"
     }
     */
    static let accessKey = AccessKey.accessKey
    
    var url: URL? {
        var path = ""
        
        switch self {
        case .getExchangeRates:
            path = "/live"
        case .getSupportedCurrencies:
            path = "/list"
        }
        return URL(string: "\(CurrencyConverterRequests.baseURL)\(path)?access_key=\(CurrencyConverterRequests.accessKey)")
    }
}