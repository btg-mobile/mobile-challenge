//
//  CurrencyConverter.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 23/10/21.
//

import Foundation


class CurrencyConverter {
    
    public static func converter(fromQuote: Quotes, toQuote: Quotes, value: Float)-> Float {
        if(value == 0) {
            return 0
        }
        
        let dolarValue = CurrencyConverter.calculateCurrencyToDolar(quote: fromQuote.quote)
        //Calcula o valor final
        return (toQuote.quote * dolarValue) * value
    }
    
    private static func calculateCurrencyToDolar(quote: Float)-> Float {
        return 1 / quote
    }
}
