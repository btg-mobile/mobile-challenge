//
//  Conversion.swift
//  CurrencyConverterBTG
//
//  Created by Silvia Florido on 19/06/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation

class Conversion: NSObject {
    let fromCurrency: Currency  // user input
    let toCurrency: Currency   // user input
    var fromAmount: Decimal    // user input
    var toAmount: Decimal      // from api and/or calculated
    let timestamp: Date       // from api
    let conversionType: ConversionType = .baseUSD
    
    init(from: Currency, to: Currency, fromAmount: Decimal, toAmount: Decimal, timestamp: Date) {
        self.fromCurrency = from
        self.toCurrency = to
        self.fromAmount = fromAmount
        self.toAmount = toAmount
        self.timestamp = timestamp
    }
    
    static func ==  (lhs: Conversion, rhs: Conversion) -> Bool {
        let from = lhs.fromCurrency.code == rhs.fromCurrency.code
        let to = lhs.toCurrency.code == rhs.toCurrency.code
        return from && to
    }
    
    func convert() -> Decimal?  {
        
        // get quotes from api or cache
        
        
//        if let conversion = cache.convesion {
//            return conversion
//        }
//        repo.quotesList
//        let quotesList = QuotesList()
        
        if conversionType == .baseUSD {
//            let quotes = quotesList.getFreeQuotes(fromCurrency: fromCurrency, toCurrency: toCurrency)
//            guard let usdFrom = quotes.usdFrom, let usdTo = quotes.usdTo else {
//                return nil  // Error  no quotes available for this conversion
//            }
//            toAmount = (usdTo.quote / usdFrom.quote) * fromAmount
//            
            // save to history
            
            return toAmount
        } else {
            return nil
        }
    }
    
    /*
     o usuario insere from to e amount
     pega da api as quotes free (lista)
     cria as quotes de usdFrom e de usdTo
     calcula a conversão  (usdTo / usdFrom) * valorTo = valorFrom
     
     salva a conversão no historico
     */
    
}

enum ConversionType {
    case baseUSD
    case direct
}
