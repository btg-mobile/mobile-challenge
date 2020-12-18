//
//  CurrencyModelViewController.swift
//  CurrencyChallenge
//
//  Created by Higor Chaves Peres on 16/12/20.
//

import Foundation
import UIKit

protocol CurrenciesUpdateDelegate: class {
    func updateCurrencies()
}

final class SearchCurrencyViewModelController {
    
    var updateHandler: () -> Void = {}
    private(set) var supportedCurrencies : SupportedCurrencies!
    private(set) var realTimeRates : RealTimeRates!
    private(set) var currencies : [Currency] = []
    private var sessionProvider: URLSessionProvider = URLSessionProvider()
    
    weak var delegate : CurrenciesUpdateDelegate!
    
    init(controller: SearchCurrencyViewController) {
        self.delegate = controller
    }
    
    private func updateCurrencies() {
        for (key,value) in supportedCurrencies.currencies {
            currencies.append(Currency(abbreviation: key, fullName: value))
        }
        delegate.updateCurrencies()
    }
    
    func updateSupportedCurrencies(){
        sessionProvider.request(type: SupportedCurrencies.self, service: CurrencyService.list) { (response) in
            
            switch response {
            case let .success(response):
                self.supportedCurrencies = response
                self.updateCurrencies()
            case let .failure(error):
                print(error)
            }
        }
    }
}
