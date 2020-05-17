//
//  BTGCurrencyQuotesController.swift
//  BTGConverterAPP
//
//  Created by Leonardo Maia Pugliese on 15/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import Foundation

class BTGCurrencyQuotesController {
    
    private let networkController = BTGNetworkController.shared
    private var quotes : [String: Double]? {
        didSet {
            error = ""
        }
    }
    private var error : String = ""
    private var lastTimeUpdated = ""
    private let localStorage : LocalStorage = BTGLocalStorage()
    
    func getQuotes() -> [String: Double]? {
        loadQuotes()
        return quotes
    }
    
    func getLastError()-> String {
        return error
    }
    
    func getLastTimeUpdatedFormatted() -> String {
        return lastTimeUpdated
    }
    
    func loadQuotes() {
        if localStorage.isValid() {
            quotes = localStorage.getLiveQuoteRates()?.quotes
            //print(quotes)
        } else {
                networkController.getLiveCurrencies { [weak self] in
                    switch $0 {
                    case .success(let result):
                        self?.localStorage.setLiveQuoteRates(result)
                        self?.quotes = result.quotes
                        let components =  self!.getFormattedDate(liveQuoteRates: result)
                        self?.lastTimeUpdated = "\(components[0]) \(components[1])"
                    case .failure(let resultError):
                        self?.error = resultError.rawValue
                    }
                }
        }
    }
    
    func getFormattedDate(liveQuoteRates: LiveQuoteRates) -> [String] {
        let newDate = liveQuoteRates.timestamp
        return newDate.addingTimeInterval(liveQuoteRates.timestamp
            .distance(to: Date()))
            .addingTimeInterval(TimeInterval(integerLiteral: -3600*3))
            .description.components(separatedBy: " ")
    }
    
}
