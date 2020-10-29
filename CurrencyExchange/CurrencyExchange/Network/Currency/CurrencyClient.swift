//
//  CurrencyClient.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import Foundation


struct CurrencyClient: APIClient {
    
    var session: URLSession
    typealias listFetchCompletion = (Result<CurrencyList, APIError>) -> Void
    
    init(configuration: URLSessionConfiguration){
        self.session = URLSession(configuration: configuration)
    }
    
    init(){
        self.init(configuration: .default)
    }
    
    func getListOfCurrencies(completion: @escaping listFetchCompletion){
        
        guard let request = CurrencyProvider.list.request else {
            return completion(.failure(.badRequest))
        }
        
        fetch(withRequest: request, withDecondingType: CurrencyList.self) { (result) in
            
            switch result {
                
            case .success(let currencyList):
                completion(.success(currencyList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
