//
//  NetworkManager.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation

class NetworkManager {
    
    let baseURL = "http://api.currencylayer.com"
    let accessKey = "c973339d098633a0d3ec6bb507bb286e"
    
    func request<T:DataModelProtocol>(model: T.Type, result: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let url = makeURL(service: T.service.rawValue) else {
            result(.failure(NetworkError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                var networkError: NetworkError = .unknownError
                if error.localizedDescription.uppercased().contains("OFFLINE") {
                    networkError = .APIOffline
                }
                result(.failure(networkError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                result(.failure(.APIError))
                return
            }
            
            if let data = data, let decodedData: T = self.decode(data: data) {
                print(decodedData)
                result(.success(decodedData))
                return
            } else {
                result(.failure(.decodeFailure))
                return
            }
            
        }.resume()
    }
    
    private func decode<T: Decodable>(data: Data) -> T? {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(T.self, from: data) else { return nil }
        
        return decodedData
    }
    
    private func makeURL(service: String) -> URL? {
        return URL(string: "\(baseURL)/\(service)?access_key=\(accessKey)")
    }
}
