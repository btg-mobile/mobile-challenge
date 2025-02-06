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
    
    
    func convertValueAccordingToCurrency(conversionResponse: ConversionResponse?, valueToConvert: String, currencySource: String, currencyDestination: String) -> Double {

        var convertedValue: Double
        var intermediateConversion: Double
        var currencyPair = currencySource + currencyDestination
        var amountToConvert = Double(valueToConvert)
        
        if let conversion = conversionResponse?.quotes {
            for i in conversion {
                if !currencyPair.contains("USD") {
                    if i.key.contains(currencySource) {
                        intermediateConversion = (amountToConvert ?? 0.0) / i.value
                        for i in conversion {
                            if i.key.contains(currencyDestination) {
                                convertedValue = intermediateConversion * i.value
                                return convertedValue
                            }
                        }
                    }
                } else if currencyPair == i.key {
                    convertedValue = (amountToConvert ?? 0.0) * i.value
                    return convertedValue
                }
                
                
            }
        }
        
        return 0

    }
    
    
    
    
}



