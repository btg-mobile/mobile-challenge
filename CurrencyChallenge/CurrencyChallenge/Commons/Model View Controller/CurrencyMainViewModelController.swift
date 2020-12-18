//
//  CurrencyMainViewModelController.swift
//  CurrencyChallenge
//
//  Created by Higor Chaves Peres on 17/12/20.
//

import Foundation

final class CurrencyMainViewModelController{
    
    var updateHandler: () -> Void = {}
    private(set) var realTimeRates : RealTimeRates!
    private(set) var quotes : [Quote] = []
    private var sessionProvider: URLSessionProvider = URLSessionProvider()
    
    
    func compareQuotes(first: Quote, second: Quote)->Double{
        return first.value/second.value
    }
    
    func searchQuote(currency: Currency)->Quote?{
        for quote in quotes {
            if quote.name.contains(currency.abbreviation) {
                return quote
            }
        }
        return nil
    }
    
    private func updateQuotes() {
        for (key,value) in realTimeRates.quotes {
            quotes.append(Quote(name: key, value: value))
        }
    }
    
    func updateRealTimeRates(){
        sessionProvider.request(type: RealTimeRates.self, service: CurrencyService.live) { (response) in
            
            switch response {
            case let .success(response):
                self.realTimeRates = response
                self.updateQuotes()
            case let .failure(error):
                print(error)
            }
        }
    }
}
