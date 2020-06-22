//
//  Conversion.swift
//  CurrencyConverterBTG
//
//  Created by Silvia Florido on 19/06/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation

enum ConversionType {
    case baseUSD
    case direct
}

class Conversion: NSObject {
    let fromCurrency: Currency
    let toCurrency: Currency
    var fromAmount: Decimal
    var toAmount: Decimal?
    let timestamp: Date? 
    let conversionType: ConversionType = .baseUSD
    
    init(from: Currency, to: Currency, fromAmount: Decimal, toAmount: Decimal?, timestamp: Date?) {
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
    
    func convertFree(with quotes: QuotesList) -> Decimal? {
        let freeQuotes = quotes.getFreeQuotes(fromCurrency: fromCurrency, toCurrency: toCurrency)
        guard let usdFrom = freeQuotes.usdFrom,
            let usdTo = freeQuotes.usdTo else {
            return nil
        }
        let result =  (usdTo.quote / usdFrom.quote) * fromAmount
        return result
    }
    
    func convert(with quotes: QuotesList) -> Decimal? {
            if self.conversionType == .baseUSD {
                return convertFree(with: quotes)
                //   improvements: save a history of the conversions or the most used conversions
            } else {
                //  future paid conversions
                return nil
            }
    }
}

