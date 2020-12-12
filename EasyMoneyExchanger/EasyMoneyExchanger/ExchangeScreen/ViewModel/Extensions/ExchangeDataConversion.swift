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

    func calcConvertion(fromCurrency: String, toCurrency: String) -> Float {
        // Pegar o valor de From pra USD
        var fromValue = coreData.rateItems![0].quotes!["USD\(fromCurrency)"]
        fromValue = 1 / fromValue!

        // Pegar o valor de To pra USD
        var toValue = coreData.rateItems![0].quotes!["USD\(toCurrency)"]

        toValue = 1 / toValue!

        print(fromValue!)
        print(toValue!)
        // Calcular
        return fromValue! / toValue!
    }
}
