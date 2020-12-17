//
//  Networking.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 16/12/20.
//

import Foundation

protocol Networking {
    func execute<T: Decodable>(_ requestProviding: URLRequestProviding,
                             completion: @escaping (Result<T, Error>) -> Void)
}

extension Networking {
    func execute<T: Decodable>(_ requestProviding: URLRequestProviding,
                             completion: @escaping (Result<T, Error>) -> Void) {

        let urlRequest = requestProviding.urlRequest

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            do {
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(NetworkingError.noDataReceived))
                    return
                }

                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))

            } catch {
                completion(.failure(NetworkingError.unknown))
            }
        }.resume()
    }
}
