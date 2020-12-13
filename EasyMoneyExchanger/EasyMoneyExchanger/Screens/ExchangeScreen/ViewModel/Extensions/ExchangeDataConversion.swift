//
//   DataConversion.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 12/12/20.
//

import Foundation
import UIKit

extension ExchangeViewModel {
    // MARK: - Data Convertion Methods

    func convertSupportedCurrenciesToFlags(data: [String: String]) -> CurrencySupported {
        var newElement: [String: String] = ["BRL": "BRL"]

        for (key, _) in data {
            newElement[key] = Flags.codeToFlag[key]
        }

        return CurrencySupported(currencies: newElement)
    }

    func getConvertionCurrency(fromCurrency: String, toCurrency: String, amount: Float) -> Float {
        // Pegar o valor de From pra USD
        var fromValue = coreData.rateItems![0].quotes!["USD\(fromCurrency)"]
        fromValue = 1 / fromValue!

        // Pegar o valor de To pra USD
        var toValue = coreData.rateItems![0].quotes!["USD\(toCurrency)"]

        toValue = 1 / toValue!

        // Calcular
        return (fromValue! / toValue!) * amount
    }

    func inverCurrencies(tableView: UITableView, fromCurrency: String, toCurrency: String) {
        coreData.updateExchangeTo(tableView: tableView, to: fromCurrency)
        coreData.updateExchangeFrom(tableView: tableView, from: toCurrency)
    }

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
