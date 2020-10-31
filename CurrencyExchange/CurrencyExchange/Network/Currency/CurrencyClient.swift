//
//  CurrencyClient.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import Foundation


struct CurrencyClient: APIClient {
    
    var session: URLSessionProtocol
    typealias listFetchCompletion = (Result<CurrencyList, APIError>) -> Void
    
    init(session: URLSessionProtocol = URLSession.shared){
        self.session = session
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
