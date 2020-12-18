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

    private var service: CurrencyListProviding
    private var onUpdate: () -> Void
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
