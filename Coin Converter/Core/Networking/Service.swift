//
//  Service.swift
//  Coin Converter
//
//  Created by Igor Custodio on 28/07/21.
//

import Foundation

class Service: ServiceProtocol {
    
    private let apiBaseUrl: String
    private let session: URLSession
    
    init() {
        apiBaseUrl = Environment.shared.variable(.apiBaseUrl)
        session = URLSession(configuration: .default)
    }
    
    func request(route: ApiRoute, completion: @escaping (Result) -> ()) {
        do {
            let url = try route.getUrl(apiBase: apiBaseUrl)
            
            let task = session.dataTask(with: url) { (data, urlResponse, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(.failure(error: error))
                        return
                    }
                    
                    if let error = self.handleStatusCode(urlResponse?.getStatusCode()) {
                        completion(.failure(error: error))
                    }
                    
                    guard let data = data else {
                        completion(.failure(error: ErrorType.defaultError))
                        return
                    }
                    
                    completion(.success(data: data))
                }
            }
            
            task.resume()
        } catch let error {
            print(error)
            completion(.failure(error: error))
        }
    }
    
    private func handleStatusCode(_ statusCode: Int?) -> ErrorType? {
        if let statusCode = statusCode {
            switch statusCode {
                case 200...299:
                    return nil
                case 404:
                    return .notFound
                case 400...499:
                    return .badRequest
                case 500...599:
                    return .serverError
                default:
                    return .defaultError
            }
        } else {
            return .defaultError
        }
    }
}

extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        
        return nil
    }
}
