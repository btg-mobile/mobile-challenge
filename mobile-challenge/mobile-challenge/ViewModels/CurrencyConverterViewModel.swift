//
//  CurrencyConverterViewModel.swift
//  mobile-challenge
//
//  Created by gabriel on 29/11/20.
//

import Foundation

class CurrencyConverterViewModel {
    
    private(set) var quotes: CurrencyQuotes? {
        didSet {
            self.quotesFetched()
        }
    }
    
    // MARK: Bindings
    var quotesFetched: (() -> Void) = {}
    
    func getQuotes() -> Void {
        
        CurrencyQuotesService.getQuotes { (answer) in
            switch answer {
            case .result(let quotes as CurrencyQuotes):
                self.quotes = quotes
            case .error(let error as URLParsingError):
                debugPrint(error)
                self.quotes = nil
            case .error(let error as DataTaskError):
                debugPrint(error)
                self.quotes = nil
            default:
                self.quotes = nil
            }
        }
    }
    
    func convert(_ value: Double, from origin: String, to destiny: String) -> Double? {
        let usdOriginKey = "USD" + origin
        let usdDestinyKey = "USD" + destiny
                
        guard let quotes = self.quotes,
              let originUSD = quotes.quotes[usdOriginKey],
              let destinyUSD = quotes.quotes[usdDestinyKey] else {
            return nil
        }
        
        return (value / originUSD) * destinyUSD
    }
    
    private func getCachedQuotes() {
        
    }
}
