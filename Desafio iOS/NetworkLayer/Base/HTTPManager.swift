//
//  HTTPProvider.swift
//  Desafio iOS
//
//  Created by Lucas Soares on 28/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public typealias onCompletion<T: Decodable> = ((_ result: (T?, Error?)) -> Void)?

class HTTPManager<Router: HTTPRouter> {
    
    // MARK: - Instance Properties
    
    private var timeoutInterval: TimeInterval = 10
    private var decoder = JSONDecoder()
    
    // MARK: - Public Methods
    
    private func buildURLRequest(router: Router) -> URLRequest {
        var url = router.baseUrl
        url?.appendPathComponent(router.path)
        
        var components = URLComponents(string: url!.absoluteString)!
        components.queryItems = router.parameters.map { component in
            URLQueryItem(name: component.key, value: component.value)
        }
        //add access key to request.
        components.queryItems?.append(
            URLQueryItem(name: "access_key", value: Constants.Network.accessKey)
        )
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = router.method.rawValue
        request.timeoutInterval = timeoutInterval
        request.allHTTPHeaderFields = router.headers
        
        return request
    }
    
    func request<T: Decodable>(router: Router, successCompletion: onCompletion<T>) {
        let request = buildURLRequest(router: router)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            DispatchQueue.main.async {
                if let error = error {
                    successCompletion?((nil, error))
                    return
                }
                
                if let data = data {
                    do {
                        let decodedObject = try self.decoder.decode(T.self, from: data)
                        successCompletion?((decodedObject, nil))
                    } catch {
                        successCompletion?((nil, error))
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    
}

