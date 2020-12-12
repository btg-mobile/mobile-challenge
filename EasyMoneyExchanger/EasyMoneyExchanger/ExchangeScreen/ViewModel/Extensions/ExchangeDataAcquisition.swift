//
//  FetchData.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 12/12/20.
//

import Foundation
import UIKit

extension ExchangeViewModel {
    // MARK: - Service Methos

    func fetchRealtimeRates(isUpdating updating: Bool, tableView: UITableView) {
        let url = URL(string: "http://api.currencylayer.com/live")!
        print("Pasou no Realtime Fetch")
        service.fetchCurrencyRates(url: url) { result in
        switch result {
        case .success(let response):
            if updating {
                self.coreData.updateRates(tableView: tableView, currencyRates: response)
            } else {
                self.coreData.addRates(tableView: tableView, realtimeRates: response)
            }
        case .failure(let myError):
                print(myError)
            }
        }
    }

    func fetchSupportedCurrencies(isUpdating updating: Bool, tableView: UITableView) {
        let url = URL(string: "http://api.currencylayer.com/list")!
        print("Pasou no Supported Fetch")
        service.fetchSupportedCurrencies(url: url) { result in
        switch result {
        case .success(let response):
            if updating {
                self.coreData.updateSupported(tableView: tableView, supportedCurrencies: response)
            } else {
                self.coreData.addSupportedCurrencies(tableView: tableView, supprtedCurrencies: response)
            }
        case .failure(let myError):
                print(myError)
            }
        }
    }
}
