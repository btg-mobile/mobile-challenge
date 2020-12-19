//
//  NetworkService.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 18/12/20.
//

import Foundation

/// The service responsible for performing network requests.
protocol NetworkService {
    
    /**
     This function creates a DataTask from a URL request, and when resumed, triggers a completion handler with its answer.

     - Warning: This method is asyncronous.

     - Parameter request: The URL Request.
     - Parameter decodableType: The decodable type that conforms to the get request answer.
     - Parameter completion: The block of code that will execute after the get request is executed.
     */
    func createTask<T: Decodable>(request: URLRequest, decodableType: T.Type, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
