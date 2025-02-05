//
//  ConversionViewModel.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 04/02/25.
//

import Foundation

class ConversionViewModel {
    var conversion: ConversionResponse?
    let conversionManager: ConversionManager

    init(conversionManager: ConversionManager) {
        self.conversionManager = conversionManager
    }
    
    func getConversionsData() async throws -> ConversionResponse {
        conversion = try await conversionManager.fetchRequest()
        return conversion ?? ConversionResponse(quotes: [:])
    }
    
    
}
