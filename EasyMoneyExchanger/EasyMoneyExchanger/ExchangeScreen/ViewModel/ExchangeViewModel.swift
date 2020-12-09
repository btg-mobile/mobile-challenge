//
//  ExchangeViewModel.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 09/12/20.
//

import Foundation
class ExchangeViewModel {

    var currencyRates: RealtimeRates
    let service: CurrencyLayerAPI

    init(currencyRates: RealtimeRates, service: CurrencyLayerAPI) {
        self.currencyRates = currencyRates
        self.service = service
    }

    func fetchRealtimeRates() {
        let url = URL(string: "http://api.currencylayer.com/live")!
        print("passou fetch")
        service.fetchAPI(url: url) { result in
        switch result {
        case .success(let response):
                self.currencyRates = response
            print(response.quotes)
        case .failure(let myError):
                print(myError)
            }
        }
    }
}
