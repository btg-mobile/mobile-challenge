//
//  NetworkService.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 18/12/20.
//

import Foundation

/// The service responsible for performing network requests.
protocol NetworkService {
    
    func createTask<T: Decodable>(request: URLRequest, decodableType: T.Type, completion: ((TaskAnswer<Any>) -> Void)?) -> URLSessionDataTask 
}
