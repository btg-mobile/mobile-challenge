//
//  ExchangeViewModel.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 02/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import Foundation
import UIKit

class ExchangeViewModel {
    fileprivate let localCurrency: Currency
    fileprivate let foreignCurrency: Currency
    
    init(localCurrency: Currency, foreignCurrency: Currency) {
        self.localCurrency = localCurrency
        self.foreignCurrency = foreignCurrency
    }
    
    func goToList() {
        Router.shared.setViewController(viewController: CurrenciesListViewController())
    }
    
    func setLabels(localLabel: UILabel, foreignLabel: UILabel) {
        localLabel.text = localCurrency.abbreviation
        foreignLabel.text = foreignCurrency.abbreviation
    }
    
    func convertLocalToForeign(value: Double) -> Double {
        let localInUsd = value * localCurrency.usdQuote
        return localInUsd / foreignCurrency.usdQuote
    }
}
