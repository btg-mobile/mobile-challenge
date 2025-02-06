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
    
    
    func converterMoeda(valueToConvert: String, currencySource: String, currencyDestination: String) -> Double {

        var resultadoFinal: Double
        
        var result: Double
        
        var quotes = currencySource + currencyDestination
        var valueDouble = Double(valueToConvert)
        
        if let conversion = conversion?.quotes {
            for i in conversion {
                if !quotes.contains("USD") {
                    if i.key.contains(currencySource) {
                        result = (valueDouble ?? 0.0) / i.value
                        for i in conversion {
                            if i.key.contains(currencyDestination) {
                                resultadoFinal = result * i.value
                                return resultadoFinal
                            }
                        }
                    }
                } else if quotes == i.key {
                    resultadoFinal = (valueDouble ?? 0.0) / i.value
                    print(resultadoFinal)
                    return resultadoFinal
                }
                
                
            }
        }
        
        return 0

    }
    
    
    
    
}


//if let conversion = conversion?.quotes {
//    for i in conversion {
//            if quotes.contains("USD") && quotes.contains(currencyDestination){
//                resultadoFinal = (valueDouble ?? 0.0) / i.value
//                print(resultadoFinal)
//                return resultadoFinal
//            } else if !quotes.contains("USD"){
//                if quotes.contains(currencySource) {
//                    resultadoFinal = (valueDouble ?? 0.0) / (i.value * i.value)
//                    return resultadoFinal
//                }
//
//            }
//        }
//    }
