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
    
    // MARK: - Funcs
    func setCurrency(_ currency: Currecy, type: CurrencyType) {
        switch type {
        case .origin:
            originCurrency = currency
        case .target:
            targetCurrency = currency
        }
    }
}
