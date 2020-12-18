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

    var service: CurrencyListProviding

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
    private var onUpdate: () -> Void
    private let formatter = NumberFormatter()
    var quotes = [String: Double]()

    init(originCurrency: Currency = .brl,
         targetCurrency: Currency = .usd,
         service: CurrencyListProviding,
         onUpdate: @escaping () -> Void) {
        self.originCurrency = originCurrency
        self.targetCurrency = targetCurrency
        self.service = service
        self.onUpdate = onUpdate
        onUpdate()

        formatter.numberStyle = .currency

        service.getCurrencyList { result in
            switch result {
            case .success(let list):
                self.originCurrency = list.currencies[Int.random(in: 0..<list.currencies.count)]
                self.targetCurrency = list.currencies[Int.random(in: 0..<list.currencies.count)]
            case .failure(let error):
                print(error)
            }
        }
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
}
