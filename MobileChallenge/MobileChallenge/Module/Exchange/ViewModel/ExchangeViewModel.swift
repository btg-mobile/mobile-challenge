//
//  ExchangeViewModel.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 04/11/20.
//

import Foundation

class ExchangeViewModel {

    func fetchAllExchanges(completionHandler: @escaping (Result<[String: Double], APIError>) -> Void) {
        let request = APIRequest()
        
        request.fetchAllExchanges(completionHandler: { (result) in
            
            switch result {
            
            case .success(let exchanges):
                completionHandler(.success(exchanges ?? [:]))
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
}
