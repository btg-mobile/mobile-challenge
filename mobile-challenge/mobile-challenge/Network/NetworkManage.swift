//
//  NetworkManage.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import Foundation

final class NetworkManage {
    func request<T:Decodable>(service: ServiceProtocol,
                              resposeType: T.Type,
                              completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: service.path) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = service.method.value
        
//        if let parameters = service.parameters {
//            for (key, value) in parameters {
//                request.setValue(value, forHTTPHeaderField: key)
//            }
//        }
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let mime = response?.mimeType, mime == "application/json" else {
                completion(.failure(NSError()))
                return
            }
            
            guard
                let data = data,
                let object: T = self.decode(data: data) else {
                completion(.failure(NSError()))
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
