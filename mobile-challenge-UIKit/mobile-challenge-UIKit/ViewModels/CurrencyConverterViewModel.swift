//
//  CurrencyConverterViewModel.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 17/12/20.
//

import Foundation

class CurrencyConverterViewModel {
    var originCurrency: Currency {
        didSet {
            onUpdate()
        }
    }
    var destinationCurrency: Currency {
        didSet {
            onUpdate()
        }
    }
    var quotes = [String: Double]()
    var onUpdate: () -> Void

    init(originCurrency: Currency = .brl,
         destinationCurrency: Currency = .usd,
         onUpdate: @escaping () -> Void) {
        self.originCurrency = originCurrency
        self.destinationCurrency = destinationCurrency
        self.onUpdate = onUpdate
        fetchData()
    }

    private func fetchData() {

    }
}
