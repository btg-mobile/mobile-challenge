//
//  Quote.swift
//  CurrencyConverterBTG
//
//  Created by Silvia Florido on 21/06/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation

class Quote: NSObject {
    let fromCurrency: Currency  // BRL
    let toCurrency: Currency  // EUR
    let quote: Decimal  //  USDAUD 1.278342    1 USD = 1.278342 AUD
    let date: Date
    let timestamp: Date
    
    init(from: Currency, to: Currency, fromAmount: Decimal, quote: Decimal, date: Date, timestamp: Date) {
        self.fromCurrency = from
        self.toCurrency = to
        self.quote = quote
        self.date = date
        self.timestamp = timestamp
    }
    
    
//    convenience init(from: Currency, to: Currency, fromAmount: Double, quote: Double, date: Date, timestamp: UInt64) {
//            let quotesDict = response.quotes
//            
//            quotesDict.compactMap { (key, value) -> Quote? in
//                if key.count != 6 {
//                    return nil
//                }
//                
//                let fromCode = String(key.prefix(3))
//                let toCode = String(key.suffix(3))
//                
//                if let fromCurrency = availableCurrenciesList.getCurrency(fromCode: fromCode),
//                    let toCurrency = availableCurrenciesList.getCurrency(fromCode: toCode) {
//                    let quote = Quote(from: fromCurrency, to: toCurrency, fromAmount: 1, quote: Decimal(value), date: Date(), timestamp: response.timestamp)
//                }
//                
//    //            let currencyFrom = availableCurrenciesList.getCurrency(from: key)
//    ////            Quote(from: <#T##Currency#>, to: <#T##Currency#>, fromAmount: <#T##Decimal#>, quote: <#T##Decimal#>, date: <#T##Date#>, timestamp: <#T##Date#>)
//                
//                
//            }
//            
//        }
    
    
    static func == (lhs: Quote, rhs: Quote) -> Bool {
        let from = lhs.fromCurrency.code == rhs.fromCurrency.code
        let to = lhs.toCurrency.code == rhs.toCurrency.code
        return from && to
    }
}
