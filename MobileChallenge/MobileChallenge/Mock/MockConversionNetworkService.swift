//
//  MockConversionNetworkService.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 06/02/25.
//

import Foundation


class MockConversionNetworkService: NetworkServiceProtocol {
    
    func fetchData(urlString: String) async throws -> Data {
        let mockJson = """
    {
            "quotes": {
                "USDAED": 3.6,
                "USDAFN": 77.9,
                "USDALL": 101.4,
                "USDBRL": 5.3,
                "USDEUR": 0.8

            }

    }
    """
        
        guard let jsonData = mockJson.data(using: .utf8) else {
            throw ServiceError.requestError
        }
        
        return jsonData
    }
    
}
