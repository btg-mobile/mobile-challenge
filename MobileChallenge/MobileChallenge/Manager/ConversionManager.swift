//
//  ConversionManager.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 04/02/25.
//

import Foundation

class ConversionManager {
    let conversionNetworkService: NetworkServiceProtocol
    
    init(conversionNetworkService: NetworkServiceProtocol) {
        self.conversionNetworkService = conversionNetworkService
    }
    
    func fetchRequest() async throws -> ConversionResponse {
        let urlString = "https://raw.githubusercontent.com/Banking-iOS/mock-interview/main/api/live.json"
        
        
        do {
            let data = try await conversionNetworkService.fetchData(urlString: urlString)
            do {
                let decoder = JSONDecoder()
                let decode = try decoder.decode(ConversionResponse.self, from: data)
                return decode
            } catch {
                print(error.localizedDescription)
                throw ServiceError.invalidData
            }
        } catch {
            print("URL inválida.")
            throw ServiceError.invalidURL
        }
        
        
    }


}
