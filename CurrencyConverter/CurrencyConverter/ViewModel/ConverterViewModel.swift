//
//  ConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 29/10/20.
//

import Foundation
import CurrencyServices

protocol ConverterViewModelDelegate: class {
    func onListCurrencies()
    func onError(_ error: NSError)
}

class ConverterViewModel {
    
    private let network: CurrencyServices.CurrencylayerNetwork
    
    var currencies: [Currecy]
    weak var delegate: ConverterViewModelDelegate?
    
    // MARK: - Life Cycle
    init() {
        network = CurrencyServices.CurrencylayerNetwork()
        currencies = []
    }
}

// MARK: - APIs
extension ConverterViewModel {
    func availableCurrrencies() {
        network.list { [weak self] result in
            switch result {
            case .success(let currencies):
                self?.currencies = currencies.compactMap { try? Currecy(code: $0.key, name: $0.value) }
                self?.delegate?.onListCurrencies()
                
            case .failure(let error):
                self?.delegate?.onError(error)
            }
        }
    }
}
