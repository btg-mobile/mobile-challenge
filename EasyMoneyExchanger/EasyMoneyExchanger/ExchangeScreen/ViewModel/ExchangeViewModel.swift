//
//  ExchangeViewModel.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 09/12/20.
//

import Foundation
class ExchangeViewModel {
    var supportedCurrencies: SupportedCurrencies
    var currencyRates: RealtimeRates
    let service: CurrencyLayerAPI

    init(currencyRates: RealtimeRates, service: CurrencyLayerAPI, supportedCurrencies: SupportedCurrencies) {
        self.supportedCurrencies = supportedCurrencies
        self.currencyRates = currencyRates
        self.service = service
    }

    func fetchRealtimeRates() {
        let url = URL(string: "http://api.currencylayer.com/live")!
        print("passou fetch")
        service.fetchCurrencyRates(url: url) { result in
        switch result {
        case .success(let response):
                self.currencyRates = response
        case .failure(let myError):
                print(myError)
            }
        }
    }

    func fetchSupportedCurrencies() {
        let url = URL(string: "http://api.currencylayer.com/list")!
        print("passou fetch")
        service.fetchSupportedCurrencies(url: url) { result in
        switch result {
        case .success(let response):
                self.supportedCurrencies = response
            print(self.supportedCurrencies.currencies)
        case .failure(let myError):
                print(myError)
            }
        }
    }
}
