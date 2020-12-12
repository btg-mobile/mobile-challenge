//
//  CoreDataManager.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 10/12/20.
//

import Foundation
import UIKit

class CoreDataManager {
    let context =  (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var supportedItems: [Supported]?
    var rateItems: [Rates]?
    var exchangeItems: [Exchanges]?

    // MARK: - Core Data Add

    func addSupportedCurrencies(tableView: UITableView, supprtedCurrencies: CurrencySupported) {
        let newSupportedCurrencies = Supported(context: self.context!)
        newSupportedCurrencies.currencies = supprtedCurrencies.currencies
        print(supprtedCurrencies.currencies)
        //Save Data
        do {
            try self.context?.save()
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        } catch {

        }

    }

    func addRates(tableView: UITableView, realtimeRates: CurrencyRates) {
        let newCurrencyRates = Rates(context: self.context!)
        newCurrencyRates.quotes = realtimeRates.quotes
        newCurrencyRates.timeStamp = Int64(realtimeRates.timestamp)

        //Save Data
        do {
            try self.context?.save()
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        } catch {

        }
    }

    func addExchanges(tableView: UITableView, currenciesToConvert: CurrencyExchanges) {
//        let newCurrencyToConvert = Exchanges(context: self.context!)
//        newCurrencyToConvert.from = currenciesToConvert.currenciesConvert[]
//
//        //Save Data
//        do {
//            try self.context?.save()
//            DispatchQueue.main.async {
//                tableView.reloadData()
//            }
//        } catch {
//
//        }
    }

    // MARK: - Core Data Get

    func getSupported(tableView: UITableView) {
        do {
            self.supportedItems = try context?.fetch(Supported.fetchRequest())
            DispatchQueue.main.async {
                tableView.reloadData()
            }

        } catch {

        }
    }

    func getRates(tableView: UITableView) {
        do {
            self.rateItems = try context?.fetch(Rates.fetchRequest())
            DispatchQueue.main.async {
                tableView.reloadData()
            }

        } catch {

        }
    }

    // Fetch Core Data Currencies To Convert
    func getExchanges(tableView: UITableView) {
//        do {
//            self.coreDataExchangeItems = try context?.fetch(CurrenciesToConvert.fetchRequest())
//            DispatchQueue.main.async {
//                tableView.reloadData()
//            }
//        } catch {
//
//        }
    }

    // MARK: - Core Data Update

    func updateSupported(tableView: UITableView, supportedCurrencies: CurrencySupported) {
        let localCoreCurrencySupportedItems = self.supportedItems![0]
        localCoreCurrencySupportedItems.currencies = supportedCurrencies.currencies
        //Save Data
        do {
            try self.context?.save()
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        } catch {

        }
    }

    func updateRates(tableView: UITableView, currencyRates: CurrencyRates) {
        let localCoreRealtimeRates = self.rateItems![0]
        localCoreRealtimeRates.quotes = currencyRates.quotes
        localCoreRealtimeRates.timeStamp = Int64(currencyRates.timestamp)

        //Save Data
        do {
            try self.context?.save()
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        } catch {

        }
    }

    func updateExchanges(tableView: UITableView, currencyExchanges: CurrencyExchanges) {
//        let localCoreRealtimeRates = self.coreDataExchangeItems![0]
//        localCoreRealtimeRates.currenciesToConvert = currenciesToConvert.currenciesConvert
//        //Save Data
//        do {
//            try self.context?.save()
//            DispatchQueue.main.async {
//                tableView.reloadData()
//            }
//        } catch {
//
//        }
    }
}
