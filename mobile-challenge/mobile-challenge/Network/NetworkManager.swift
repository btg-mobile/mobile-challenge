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
    
    func request<T:Decodable>(service: String, model: T.Type, result: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = makeURL(service: service) else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            print(response)
            print(error)
        }.resume()
    }
    
    private func makeURL(service: String) -> URL? {
        return URL(string: "\(baseURL)/\(service)?access_key=\(accessKey)")
    }
}
