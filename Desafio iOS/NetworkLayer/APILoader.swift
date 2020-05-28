//
//  APILoader.swift
//  Desafio iOS
//
//  Created by Lucas Soares on 28/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import Foundation
class APILoader<T: APIHandler> {
    
    let apiRequest: T
    
    let urlSession: URLSession
    
    init(apiRequest: T, urlSession: URLSession = .shared) {
        self.apiRequest = apiRequest
        self.urlSession = urlSession
    }
    
    func loadAPIRequest(requestData: T.RequestDataType,
                        completionHandler: @escaping (T.ResponseDataType?, Error?) -> ()) {
        
        // prepare url request
        let urlRequest = apiRequest.makeRequest(from: requestData).urlRequest
        // do session task
        urlSession.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else { return completionHandler(nil, error) }
            // parse response
            do {
                let parsedResponse = try self.apiRequest.parseResponse(data: data)
                return completionHandler(parsedResponse, nil)
            } catch {
                return completionHandler(nil, error)
            }
        }.resume()
    }
}

