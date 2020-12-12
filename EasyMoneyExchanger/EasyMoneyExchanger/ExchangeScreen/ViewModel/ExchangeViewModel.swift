//
//  ExchangeViewModel.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 09/12/20.
//
import UIKit
import Foundation

class ExchangeViewModel {

    let coreData: CoreDataManager
    let service: CurrencyLayerAPI

    init(service: CurrencyLayerAPI, coreData: CoreDataManager) {
        self.service = service
        self.coreData = coreData
    }

    // MARK: - Main Methods

    // Run when the application Launch
    func initApplication(tableView: UITableView) {

        // TODO: Replace to fetch Exchanges
        // Initialize Local Data
        self.coreData.getRates(tableView: tableView)
        // Check if has local data stored
        if self.coreData.rateItems!.count > 0 {
            loadLocalData(uiTableView: tableView)
        } else {
            addLocalData(uiTableView: tableView)
        }
    }

    func loadLocalData(uiTableView: UITableView) {
        self.coreData.getSupported(tableView: uiTableView)
        self.coreData.getExchanges(tableView: uiTableView)
    }

    func addLocalData(uiTableView: UITableView) {
        fetchSupportedCurrencies(isUpdating: false, tableView: uiTableView)
        fetchRealtimeRates(isUpdating: false, tableView: uiTableView)
    }
}
