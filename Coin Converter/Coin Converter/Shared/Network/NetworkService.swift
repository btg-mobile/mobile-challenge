//
//  NetworkService.swift
//  Coin Converter
//
//  Created by Jeferson Hideaki Takumi on 27/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

import Foundation

class NetworkService {
    
    typealias Parameters = [String: String]
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private let session: URLSession = URLSession.shared
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func request<T:Decodable>(model: T.Type, endpoint: Requestable, completion: @escaping (Result<T, Error>) -> Void) {
        
        let urlRequest: URLRequest = buildRequest(endpoint.url, method: endpoint.method, headers: endpoint.headers, parameters: endpoint.parameters, customBody: endpoint.customBody)
        
        let task: URLSessionDataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            if let error: Error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let jsonObject: T = try JSONDecoder().decode(T.self, from: data!)
                completion(.success(jsonObject))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    //*************************************************
    // MARK: - Private Methods
    //*************************************************
    
    private func buildRequest(
        _ url: URL,
        method: HTTPMethod = .get,
        headers: Parameters? = nil,
        parameters: Parameters? = nil,
        customBody: Data? = nil) -> URLRequest {
        
        let newUrl: URL
        
        if let parameters: Parameters = parameters,
            var urlFormmated: String = url.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let parametersString: String = parameters.compactMap {
                return "\($0)=\($1)"
            }.joined(separator: "&")
            urlFormmated += "?\(parametersString)"
            newUrl = URL(string: urlFormmated) ?? url
        } else {
            newUrl = url
        }
        
        var urlRequest = URLRequest(url: newUrl)
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 60.0
        urlRequest.cachePolicy = .useProtocolCachePolicy
        
        if let headers = headers {
            for header in headers {
                urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        
        if let body = customBody {
            urlRequest.httpBody = body
        }
        
        return urlRequest
    }
}




