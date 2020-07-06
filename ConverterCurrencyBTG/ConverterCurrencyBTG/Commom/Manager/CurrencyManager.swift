//
//  CurrencyManager.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 30/06/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation


class CurrencyManager {
    
    @discardableResult
    private func performRequest(route: CurrencyRouter, completion: @escaping (DataResponse) -> Void) -> URLSessionDataTask {
        let session = URLSession(configuration: .ephemeral)
        let request = try! route.asURLRequest()
        let dataTask =  session.dataTask(with:request) { (data, response, error) in
            let dataResponse =  DataResponse(request: request, response: response, data: data, error: error)
            completion(dataResponse)
            
        }
        
        dataTask.resume()
        return dataTask
    }
    
    @discardableResult
    func fetchList(route: CurrencyRouter = .list, completion: @escaping  (Result<ListCurrenciesModel, Error>) -> Void) -> URLSessionTask {
        return performRequest(route: route) { (dataresponse) in
            if let error = dataresponse.error {
                completion(.failure(error))
                return
            }
            guard let data = dataresponse.data, let listModel: ListCurrenciesModel = self.decodeParse(jsonData: data) else {
                return
            }
            completion(.success(listModel))
        }
    }
    
    func currencyQuotes(completion: @escaping  (Result<ListQuotes, Error>) -> Void) {
        performRequest(route: .live) { (dataresponse) in
            if let error = dataresponse.error {
                completion(.failure(error))
                return
            }
            guard let data = dataresponse.data, let listModel: ListQuotes = self.decodeParse(jsonData: data) else {
                return
            }
            completion(.success(listModel))
        }
    }
    
    
    fileprivate func decodeParse<T: Codable>(jsonData: Data) -> T? {
        do {
            let decoder = JSONDecoder()
            let items = try decoder.decode(T.self, from: jsonData)
            return items
        } catch(let error) {
            print(error)
            return nil
        }
    }
}

public struct DataResponse {
    public let request: URLRequest?
    public let response: URLResponse?
    public let data: Data?
    public let error: Error?
    
}
