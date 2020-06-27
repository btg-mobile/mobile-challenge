//
//  CurrencyConvertionProvider.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 27/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import Foundation

protocol CurrencyConvertionProviderProtocol {
    func fetchLive(completion: @escaping CurrencyConvertionJSONCallback)
    func fetchList()
}

enum CurrencyConvertionResponse {
    case success(CurrencyConvertionJSONModel)
    case error(Error)
    case genericError
}

class CurrencyConvertionProvider: CurrencyConvertionProviderProtocol {
    
    func fetchLive(completion: @escaping CurrencyConvertionJSONCallback) {
        APIProvider.shared.fetch(withEndpoint: .live) { response in
            switch response {
            case .success(let data):
                do {
                    let jsonModel = try JSONDecoder().decode(CurrencyConvertionJSONModel.self, from: data)
                    completion(.success(jsonModel))
                } catch {
                    completion(.genericError)
                }
                break
            case .clientError(let error):
                completion(.error(error))
                break
            case .errorToFetchData:
                completion(.genericError)
                break
            }
        }
    }
    
    func fetchList() {
        
    }
}
