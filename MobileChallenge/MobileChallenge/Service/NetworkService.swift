//
//  NetworkService.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 04/02/25.
//

import Foundation

class NetworkService: NetworkServiceProtocol {
    
    func fetchData(urlString: String) async throws -> Data {
        
        guard let url = URL(string: urlString) else { throw ServiceError.invalidURL }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                throw ServiceError.invalidResponse
            }
            return data
        } catch {
            print(error.localizedDescription)
            throw ServiceError.requestError
        }
    }
    
    
}
