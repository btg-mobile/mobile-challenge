//
//  MockCurrencyNetworkService.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 06/02/25.
//

import Foundation


class MockCurrencyNetworkService: NetworkServiceProtocol {
    func fetchData(urlString: String) async throws -> Data {
        let mockJson = """
    {
            "currencies": {
                "USD": "United States Dollar",
                "EUR": "Euro"
            }

    }
    """
        
        guard let jsonData = mockJson.data(using: .utf8) else {
            throw ServiceError.requestError
        }
        
        return jsonData
    }
    
    
}
