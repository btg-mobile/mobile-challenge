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
    
    
    func convert(quotesList: QuotesList) -> Decimal?  {
        if conversionType == .baseUSD {
            let quotes = quotesList.getFreeQuotes(fromCurrency: fromCurrency, toCurrency: toCurrency)
            guard let usdFrom = quotes.usdFrom, let usdTo = quotes.usdTo else {
                return nil  // Error  no quotes available for this conversion
            }
            toAmount = (usdTo.quote / usdFrom.quote) * fromAmount
            
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
    
    static func == (lhs: Quote, rhs: Quote) -> Bool {
        let from = lhs.fromCurrency.code == rhs.fromCurrency.code
        let to = lhs.toCurrency.code == rhs.toCurrency.code
        return from && to
    }
}


struct QuotesList {
    let baseCurrency: Currency = Currency(code: "USD", name: "American Dollars")
    let quotes: [Quote]
    let date: Date
    let timeStamp: Date
    

    func getFreeQuotes(fromCurrency: Currency, toCurrency: Currency) -> (usdFrom: Quote?, usdTo: Quote?) {
        let usdFromQuote = getQuote(fromCurrency: baseCurrency, toCurrency: fromCurrency)
        let usdToQuote = getQuote(fromCurrency: baseCurrency, toCurrency: toCurrency)
        return (usdFromQuote, usdToQuote)
    }
    
    
    func getQuote(fromCurrency: Currency, toCurrency: Currency) -> Quote? {
        return quotes.first { (quote) -> Bool in
            quote.fromCurrency == fromCurrency && quote.toCurrency == toCurrency
        }
    }
    
}
