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
    func setOriginCurrency(_ currency: Currecy)
    func setTargetCurrency(_ currency: Currecy)
}

class ConverterViewModel {
    
    private let network: CurrencyServices.CurrencylayerNetwork
    
    weak var delegate: ConverterViewModelDelegate?
    var originCurrency: Currecy? {
        didSet {
            if let currency = originCurrency {
                delegate?.setOriginCurrency(currency)
            }
         }
    }
    var targetCurrency: Currecy? {
        didSet {
            if let currency = targetCurrency {
                delegate?.setTargetCurrency(currency)
            }
         }
    }
    
    // MARK: - Life Cycle
    init() {
        network = CurrencyServices.CurrencylayerNetwork()
    }
    
    // MARK: - Handlers
    func setCurrency(_ currency: Currecy, type: CurrencyType) {
        switch type {
        case .origin:
            originCurrency = currency
        case .target:
            targetCurrency = currency
        }
    }
    
    func textValueFomatter(_ text: String?) -> String {
        guard let text = text, let number = UInt64(text.filterNumbers()) else { return "" }
        var textFormatted = String(number)
        let zeros = [String](repeating: "0", count: max(3 - textFormatted.count, 0)).reduce("", { "\($0)\($1)" }) // Fill with "0" if need
        textFormatted = "\(zeros)\(textFormatted)" // Merge de value with the complement
        textFormatted.insert(".", at: textFormatted.index(textFormatted.endIndex, offsetBy: -2)) // Add dot to decimal places
        return textFormatted
    }
}
