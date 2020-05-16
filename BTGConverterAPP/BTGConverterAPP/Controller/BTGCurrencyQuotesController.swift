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
    
    func getQuotes() -> [String: Double]? {
        return quotes
    }
    
    func getLastError()-> String {
        return error
    }
    
    func loadQuotes() {
                networkController.getLiveCurrencies { [weak self] in
                    switch $0 {
                    case .success(let resultQuotes):
                        self?.quotes = resultQuotes.quotes
                    case .failure(let resultError):
                        self?.error = resultError.rawValue
                    }
                }
    }
    
}
