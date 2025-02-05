//
//  ConversionViewModel.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 04/02/25.
//

import Foundation

class ConversionViewModel {
    var conversion: ConversionResponse
    let conversionManager: ConversionManager

    init(conversion: ConversionResponse, conversionManager: ConversionManager) {
        self.conversion = conversion
        self.conversionManager = conversionManager
    }
    
    func getConversionsData() async throws -> ConversionResponse {
        conversion = try await conversionManager.fetchRequest()
        return conversion
    }
    
    
}
