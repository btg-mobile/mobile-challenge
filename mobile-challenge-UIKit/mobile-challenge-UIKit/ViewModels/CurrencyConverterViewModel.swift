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
    private var lastUpdate = Date()
    private let numberFormatter = NumberFormatter()
    private let dateFormatter = DateFormatter()

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

        numberFormatter.numberStyle = .currency
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 6
        numberFormatter.currencySymbol = ""

        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short

        getLiveRate()
    }

    func getLiveRate() {
        service.getCurrencyLiveRate { [weak self] result in
            switch result {
            case .success(let liveRate):
                self?.quotes = liveRate.quotes
                self?.lastUpdate = liveRate.lastUpdate
            case .failure(let error):
                print(error)
            }
        }
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

    func convert(text: String, completion: (String) -> Void) {
        let usdSourceKey = "\(Currency.usd.code)\(originCurrency.code)"
        let targetKey = "\(Currency.usd.code)\(targetCurrency.code)"

        guard let usdSourceRate = quotes[usdSourceKey],
              let targetRate = quotes[targetKey] else {
            return
        }

        let value = Double(text.replacingOccurrences(of: ",", with: ".")) ?? 0
        let convertedValue = value / usdSourceRate * targetRate

        guard let formattedText = numberFormatter.string(from: NSNumber(value: convertedValue)) else {
            return
        }
        
        completion(formattedText)
    }

    func getLastUpdateDate() -> String {
        return "Last update: \(dateFormatter.string(from: lastUpdate))"
    }
}
