//
//  CurrencyConverterViewModel.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 17/12/20.
//

import Foundation

class CurrencyConverterViewModel {

    enum CurrencyType {
        case origin
        case target
    }

    var onUpdate: () -> Void = { }

    private var service: CurrencyLiveRateService
    private var quotes = [String: Double]()
    private let formatter = NumberFormatter()

    private(set) var originCurrency: Currency {
        didSet {
            DispatchQueue.main.async {
                self.onUpdate()
            }
        }
    }
    
    private(set) var targetCurrency: Currency {
        didSet {
            DispatchQueue.main.async {
                self.onUpdate()
            }
        }
    }

    init(originCurrency: Currency = .brl,
         targetCurrency: Currency = .usd,
         service: CurrencyLiveRateService) {
        self.originCurrency = originCurrency
        self.targetCurrency = targetCurrency
        self.service = service

        formatter.numberStyle = .currency
    }

    func getCurrencyValue(forText text: String) -> String {
        return text
    }

    func setSelectedCurrency(_ currency: Currency, for type: CurrencyType) {
        switch type {
        case .origin:
            originCurrency = currency
        case .target:
            targetCurrency = currency
        }
        onUpdate()
    }

    func invertCurrencies() {
        let temp = originCurrency
        originCurrency = targetCurrency
        targetCurrency = temp
    }
}
