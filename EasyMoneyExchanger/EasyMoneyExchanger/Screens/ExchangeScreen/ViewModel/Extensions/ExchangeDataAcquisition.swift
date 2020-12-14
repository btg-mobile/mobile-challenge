//
//  FetchData.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 12/12/20.
//

import Foundation
import UIKit

extension ExchangeViewModel {

    func fetchRealtimeRates(isUpdating updating: Bool, tableView: UITableView, viewController: ExchangeViewController) {
        let url = URL(string: "http://api.currencylayer.com/live")!
        service.fetchCurrencyRates(url: url) { result in
        switch result {
        case .success(let response):
            if updating {
                self.coreData.updateRates(tableView: tableView, currencyRates: response)
            } else {
                self.coreData.addRates(tableView: tableView, realtimeRates: response)
            }
            DispatchQueue.main.async {
                viewController.setButtonsActivation(state: true)
            }
        case .failure(let myError):
                DispatchQueue.main.async {
                    viewController.showError(error: String(myError.localizedDescription))
                    viewController.setButtonsActivation(state: false)
                }
            }
        }
    }

    func fetchSupportedCurrencies(isUpdating updating: Bool, tableView: UITableView, viewController: ExchangeViewController) {
        let url = URL(string: "http://api.currencylayer.com/list")!
        service.fetchSupportedCurrencies(url: url) { result in
        switch result {
        case .success(let response):
            if updating {
                self.coreData.updateSupported(tableView: tableView, supportedCurrencies: response)
            } else {
                self.coreData.addSupportedCurrencies(tableView: tableView, supprtedCurrencies: response)
            }
        case .failure(let myError):
                DispatchQueue.main.async {
                    viewController.showError(error: String(myError.localizedDescription))
                    viewController.setButtonsActivation(state: false)
                }
            }
        }
    }
}
