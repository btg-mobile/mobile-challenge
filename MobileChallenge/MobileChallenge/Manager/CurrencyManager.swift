//
//  CurrencyManager.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 04/02/25.
//

import Foundation

class CurrencyManager {
    let currencyNetworkService: NetworkServiceProtocol
    
    init(currencyNetworkService: NetworkServiceProtocol) {
        self.currencyNetworkService = currencyNetworkService
    }
    
    func fetchRequest() async throws -> CurrencyResponse {
        let urlString = "https://raw.githubusercontent.com/Banking-iOS/mock-interview/main/api/list.json"
        
        
        do {
            let data = try await currencyNetworkService.fetchData(urlString: urlString)
            do {
                let decoder = JSONDecoder()
                let decode = try decoder.decode(CurrencyResponse.self, from: data)
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
