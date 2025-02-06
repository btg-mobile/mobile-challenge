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
                "USDAED": 3.672979,
                "USDAFN": 77.941225,
            }

    }
    """
        
        guard let jsonData = mockJson.data(using: .utf8) else {
            throw ServiceError.requestError
        }
        
        return jsonData
    }
    
}
