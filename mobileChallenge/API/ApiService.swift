//
//  ApiService.swift
//  mobileChallenge
//
//  Created by Henrique on 03/02/25.
//

import Foundation

class ApiService{
    static func fetchData<T: Decodable>(with endpoint: Endpoint,
                                        modelType: T.Type,
                                        completion: @escaping (Result<T, CurrencyServiceError>) -> Void) {
        guard let request = endpoint.request else { return }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.unknown(error.localizedDescription)))
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                completion(.failure(.notFound("Not found")))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodingError("Failed to decode data.")))
                }
            } else {
                completion(.failure(.unknown("No data received.")))
            }
        }.resume()
    }
}
