//
//  CurrencyManagerMock.swift
//  ConverterCurrencyBTGTests
//
//  Created by Thiago Vaz on 06/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation
@testable import ConverterCurrencyBTG


class CurrencyManagerMock: CurrencyManager {
    @discardableResult
    override func performRequest(route: CurrencyRouter, completion: @escaping (DataResponse) -> Void) -> URLSessionDataTask {
        let session = URLSession(configuration: .ephemeral)
        let request = try! route.asURLRequest()
        let dataTask =  session.dataTask(with:request) { (data, response, error) in
            let dataResponse =  DataResponse(request: request, response: response, data: data, error: error)
            completion(dataResponse)
            
        }
        
        dataTask.resume()
        return dataTask
    }

    override func fetchList(route: CurrencyRouter = .list, completion: @escaping (Result<ListCurrenciesModel, NetworkError>) -> Void) -> URLSessionTask {
        return performRequest(route: route) { (dataresponse) in
            if let list: ListCurrenciesModel = Loader.mock(file: "list") {
                completion(.success(list))
            }
        }
    }
    
    override func currencyQuotes(completion: @escaping (Result<ListQuotes, NetworkError>) -> Void) {
        performRequest(route: .live) { (dataresponse) in
            if let list: ListQuotes = Loader.mock(file: "live") {
                completion(.success(list))
            }
        }
    }
}
