//
//  Network.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 29/03/21.
//

import Foundation

class Network: Networking {
    
    // MARK: - Protocol Networking Implementation
    func execute<T: Decodable>(requestProvider: RequestProviding, completion: @escaping (Result<T, Error>) -> Void) {
        let urlRequest = requestProvider.urlRequest
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            do {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    preconditionFailure("No error was received but we also don't have data...")
                }
                
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                
                completion(.success(decodedObject))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

// MARK: - Networking Protocol
protocol Networking {
    func execute<T: Decodable>(requestProvider: RequestProviding, completion: @escaping (Result<T, Error>) -> Void)
}
