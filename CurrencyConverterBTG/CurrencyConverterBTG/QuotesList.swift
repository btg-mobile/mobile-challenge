//
//  QuotesList.swift
//  CurrencyConverterBTG
//
//  Created by Silvia Florido on 20/06/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation

class QuotesList: NSObject {
    var baseCurrency: Currency = Currency(code: "USD", name: "American Dollars")
    var quotes: [Quote] = [Quote]()
    var date: Date = Date()
    var timestamp: Date = Date()
    
    
    init(/*baseCurrency: Currency,*/ quotes: [Quote], date: Date, timestamp: Date) {
//        self.baseCurrency = baseCurrency
        self.quotes = quotes
        self.date = date
        self.timestamp = timestamp
    }
    
    convenience init(with response: LiveQuotesResponse, availableCurrenciesList: CurrenciesList) {
        let quotesTimestamp = Date(timeIntervalSince1970: response.timestamp)
        
        let quotes = response.quotes.compactMap { (key, value) -> Quote? in
            if key.count != 6 {
                return nil
            }
            let fromCode = String(key.prefix(3))
            let toCode = String(key.suffix(3))

            if let fromCurrency = availableCurrenciesList.getCurrency(fromCode: fromCode),
                let toCurrency = availableCurrenciesList.getCurrency(fromCode: toCode) {
                let quote = Quote(from: fromCurrency, to: toCurrency, fromAmount: 1, quote: Decimal.fromDouble(value), date: Date(), timestamp: quotesTimestamp)
                return quote
            } else {
                return nil
            }
        }
        self.init(quotes: quotes, date: Date(), timestamp: quotesTimestamp)
    }
    
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
