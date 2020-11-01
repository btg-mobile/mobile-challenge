//
//  ConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 29/10/20.
//

import Foundation
import CurrencyServices

enum CurrencyType {
    case origin
    case target
}

protocol ConverterViewModelDelegate: class {
    func setCurrency(_ currency: Currecy, type: CurrencyType)
    func onError(_ error: NSError)
}

class ConverterViewModel {
    
    private let network: CurrencyServices.CurrencylayerNetwork
    
    weak var delegate: ConverterViewModelDelegate?
    var originCurrency: Currecy? {
        didSet {
            if let currency = originCurrency {
                delegate?.setCurrency(currency, type: .origin)
            }
         }
    }
    var targetCurrency: Currecy? {
        didSet {
            if let currency = targetCurrency {
                delegate?.setCurrency(currency, type: .target)
            }
         }
    }
    
    // MARK: - Life Cycle
    init() {
        network = CurrencyServices.CurrencylayerNetwork()
    }
    
    // MARK: - Setups
    func setCurrency(_ currency: Currecy, type: CurrencyType) {
        switch type {
        case .origin:
            originCurrency = currency
        case .target:
            targetCurrency = currency
        }
        dolarValueForCurrencies()
    }
    
    // MARK: - Handlers
    func conversor(value: Double) -> Double {
        guard let originDolarValue = originCurrency?.inDolarValue, let targetDolarValue = targetCurrency?.inDolarValue else { return 0 }
        let convertedValue = value * targetDolarValue / originDolarValue
        return (convertedValue * 100).rounded(.toNearestOrAwayFromZero) / 100
    }
    
    func textValueFomatter(_ text: String?) -> String {
        guard let text = text, let number = UInt64(text.filterNumbers()) else { return "" }
        var textFormatted = String(number)
        let zeros = [String](repeating: "0", count: max(3 - textFormatted.count, 0)).joined() // Fill with "0" if need
        textFormatted = "\(zeros)\(textFormatted)" // Merge de value with the complement
        textFormatted.insert(".", at: textFormatted.index(textFormatted.endIndex, offsetBy: -2)) // Add dot to decimal places
        return textFormatted
    }
}

// MARK: - Requests
extension ConverterViewModel {
    func dolarValueForCurrencies() {
        guard let origin = originCurrency, let target = targetCurrency else { return }
        network.values(currenciesCodes: [origin.code, target.code]) { [weak self] result in
            switch result {
            case .success(let dict):
                self?.originCurrency?.inDolarValue = dict["USD\(origin.code)"]
                self?.targetCurrency?.inDolarValue = dict["USD\(target.code)"]
                
            case .failure(let error):
                self?.delegate?.onError(error)
            }
        }
    }
}
