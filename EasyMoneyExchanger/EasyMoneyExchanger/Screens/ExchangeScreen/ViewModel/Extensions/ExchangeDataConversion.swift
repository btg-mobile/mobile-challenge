//
//   DataConversion.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 12/12/20.
//

import Foundation
import UIKit

extension ExchangeViewModel {

    // MARK: - List Methods

    func convertSupportedCurrenciesToFlags(data: [String: String]) -> CurrencySupported {
        var newElement: [String: String] = ["BRL": "BRL"]

        for (key, _) in data {
            newElement[key] = Flags.codeToFlag[key]
        }

        return CurrencySupported(currencies: newElement)
    }

    // MARK: - Currency Methods

    func getCurrencyConverted(fromCurrency: String, toCurrency: String, amount: Float) -> Float {
        // Get From value USD
        var fromValue = coreData.rateItems![0].quotes!["USD\(fromCurrency)"]
        fromValue = 1 / fromValue!

        // Get To Value
        var toValue = coreData.rateItems![0].quotes!["USD\(toCurrency)"]

        toValue = 1 / toValue!

        // Calculate
        return (fromValue! / toValue!) * amount
    }

    func invetCurrencies(tableView: UITableView, fromCurrency: String, toCurrency: String) {
        coreData.updateExchangeTo(tableView: tableView, to: fromCurrency)
        coreData.updateExchangeFrom(tableView: tableView, from: toCurrency)
    }

    // MARK: - Time Handle Methods

    func getDateString(timestamp: Int64) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        // Set timezone
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current

        // Specifing format
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: date)
    }
}
