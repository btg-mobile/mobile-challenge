//
//  MainViewModel.swift
//  btg-challenge
//
//  Created by Wesley Araujo on 13/09/20.
//  Copyright © 2020 Wesley Araujo. All rights reserved.
//

import UIKit

protocol MainViewModelDelegate {
    func didGetQuotesCurrency(_ quotes: Live)
    func didGetError(_ error: Error)
}

class MainViewModel: ViewModel {
    
    var viewController: UIViewController?
    var service: MainService = MainService()
    var live: Live?
    
    required init() {
        service.viewModel = self
        
        // For unit test
        live = Live(success: true,
                      terms: " ",
                      privacy: " ",
                      timestamp: 8777,
                      source: " ",
                      quotes: ["USDBRL": 5.31, "USDAED": 3.67, "USDEUR": 0.84])
    }
    
    func setViewController(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func getQuotesCurrency() {
        service.getQuotesCurrency()
    }
    
    func convertCurrency(from sourceCurrency: String, to destinyCurrency: String, withValue value: Double) -> Double? {
        guard let quote = live?.quotes?[destinyCurrency] else { return nil }
        return value / quote
    }
    
    func selectSourceCurrency(_ sourceCurrency: String) -> [String: Double]? {
        guard let value = live?.quotes?[sourceCurrency] else { return nil }
        return ["\(sourceCurrency)": value]
    }
    
    func selectDestinyCurrency(_ destinyCurrency: String) -> [String: Double]? {
        guard let value = live?.quotes?["USD\(destinyCurrency)"] else { return nil }
        return ["USD\(destinyCurrency)": value]
    }
    
    func selectCurrencyQuote(from currency: String) -> [String: Double]? {
        guard let quoteValue = live?.quotes?["USD\(currency)"] else { return nil }
        return ["USD\(currency)": quoteValue]
    }
}

extension MainViewModel: MainViewModelDelegate {
    func didGetQuotesCurrency(_ quotes: Live) {
        self.live = quotes
    }
    
    func didGetError(_ error: Error) {
        
    }
}


