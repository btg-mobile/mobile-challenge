//
//  NetworkManager.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 25/11/20.
//

import Foundation

class NetworkManager {
    func request<T: Decodable>(service: NetworkServiceType, model: T.Type, completion: @escaping (Result<T,Error>) -> Void) {
        guard let url = URL(string: service.path) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                //TODO: handle error
                completion(.failure(error))
            }
            
            guard let safeData = data, let object: T = self.decode(data: safeData) else {
                // error to decode
                return
            }
            
            completion(.success(object))
        }.resume()
    }
    
    private func decode<T: Decodable>(data: Data) -> T? {
        let decoder = JSONDecoder()
        
        guard let object = try? decoder.decode(T.self, from: data) else { return nil }
        
        return object
    }
}
