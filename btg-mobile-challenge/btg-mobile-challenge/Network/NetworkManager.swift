//
//  NetworkManager.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 01/10/20.
//

import Foundation

/// Object responsible for managing network requests.
/// Stubbing `NetworkService` is suggested when testing.
final class NetworkManager {

    //- MARK: Properties
    /// The service responsible for performing the requests.
    private let service: NetworkService

    //- MARK: Init
    /// Initializes a new instance of this type.
    /// - Parameter service: The service responsible for performing the requests.
    init(service: NetworkService = URLSession.shared) {
        self.service = service
    }

    //- MARK: API
    /// Performs a request using the `service` provided to the `NetworkManager`.
    /// - Parameter request: The `URLRequest` used in the request.
    /// - Parameter type: The `Decodable` type expected in the response.
    /// - Parameter completion: The completion block containing the response.
    func perform<T: Decodable>(_ request: URLRequest, for type: T.Type, completion: @escaping (Result<T, NetworkServiceError>) -> Void) {
        service.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(NetworkServiceError.requestFailed))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkServiceError.unexpectedResponseType))
                return
            }
            
            if httpResponse.statusCode == 200 {
                guard let data = data else {
                    completion(.failure(NetworkServiceError.missingData))
                    return
                }
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(NetworkServiceError.decodingFailed))
                }
            } else {
                completion(.failure(NetworkServiceError.unexpectedHTTPStatusCode))
            }
        }.resume()
    }
}
