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
    func performRequest(route: CurrencyRouter, completion: @escaping (DataResponse) -> Void) -> URLSessionDataTask {
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
    func fetchList(route: CurrencyRouter = .list, completion: @escaping  (Result<ListCurrenciesModel, NetworkError>) -> Void) -> URLSessionTask {
        return performRequest(route: route) { (dataresponse) in
            if let error = dataresponse.error {
                completion(.failure(self.errorDefault(error: error, data: dataresponse.data ?? Data())))
                return
            }
            guard let data = dataresponse.data else {
                return
            }
            
            if let listModel: ListCurrenciesModel = self.decodeParse(jsonData: data)  {
                completion(.success(listModel))
            } else if let errorModel: ErrorModel = self.decodeParse(jsonData: data) {
                completion(.failure(self.errorModel(error: errorModel)))
            }else{
                completion(.failure(.jsonDecoding))
            }
        }
    }
    
    
    func errorDefault(error: Error, data: Data) -> NetworkError{
        if let nsError = error as? NSError, nsError.code ==  NSURLErrorNotConnectedToInternet{
            return .noConnection
        }else{
            return .http(statusCode: error._code, rawResponseData: data)
        }
    }
    
    func errorModel(error: ErrorModel)-> NetworkError {
        switch error.error.code {
        case 104:
            return NetworkError.exceededAPI
        case 101:
            return .keyInvalid
        default:
            return .timeout
        }
    }
    
    func currencyQuotes(completion: @escaping  (Result<ListQuotes, NetworkError>) -> Void) {
        performRequest(route: .live) { (dataresponse) in
            if let error = dataresponse.error {
                completion(.failure(self.errorDefault(error: error, data: dataresponse.data ?? Data())))
                return
            }
            
            guard let data = dataresponse.data else {
                return
            }
            
            if let listModel: ListQuotes = self.decodeParse(jsonData: data)  {
                completion(.success(listModel))
            } else if let errorModel: ErrorModel = self.decodeParse(jsonData: data){
                completion(.failure(self.errorModel(error: errorModel)))
            }else {
                 completion(.failure(.jsonDecoding))
            }
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
