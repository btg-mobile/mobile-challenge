//
//  URLSessionProvider.swift
//  CurrencyChallenge
//
//  Created by Higor Chaves Peres on 16/12/20.
//

import Foundation

final class URLSessionProvider: ProviderProtocol {
    
    private var session: URLSessionProtocol
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    func request<T>(type: T.Type, service: ServiceProtocol,
                    completion: @escaping (NetworkResponse<T>) -> Void) where T: Decodable {
        let request = URLRequest(service: service)
        let task = session.dataTask(request: request, completionHandler: { [weak self] data, response, error in
            let httpResponse = response as? HTTPURLResponse
            self?.handleDataResponse(data: data, response: httpResponse, error: error, completion: completion)
        })
        task.resume()
    }
    private func handleDataResponse<T: Decodable>(data: Data?, response: HTTPURLResponse?, error: Error?,
                                                  completion: (NetworkResponse<T>) -> Void) {
        guard error == nil else { return completion(.failure(
            .unknown(message: error?.localizedDescription ?? "Has no detailed error message"))) }
        guard let response = response else { return completion(.failure(.noJSONData)) }
        switch response.statusCode {
        case 200...299:
            guard let data = data, let model = try? JSONDecoder().decode(T.self, from: data)
                else {
                return completion(.failure(
                    .unknown(message: error?.localizedDescription ?? "Has no detailed error message"))) }
            completion(.success(model))
        default:
            completion(.failure(.unknown(message: error?.localizedDescription ?? "Has no detailed error message")))
        }
    }
}
