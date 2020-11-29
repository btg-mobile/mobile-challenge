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
    
    // Bindings
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
}
