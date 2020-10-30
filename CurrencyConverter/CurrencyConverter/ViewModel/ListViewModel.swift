//
//  ListViewModel.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 30/10/20.
//

import Foundation
import CurrencyServices

protocol ListViewModelDelegate: class {
    func onListCurrencies()
    func onError(_ error: NSError)
}

class ListViewModel {
    
    private let network: CurrencyServices.CurrencylayerNetwork
    
    var type: CurrencyType
    var currencies: [Currecy]
    weak var delegate: ListViewModelDelegate?
    
    // MARK: - Life Cycle
    init(type: CurrencyType) {
        self.type = type
        self.network = CurrencyServices.CurrencylayerNetwork()
        self.currencies = []
    }
}

// MARK: - APIs
extension ListViewModel {
    func availableCurrrencies() {
        network.list { [weak self] result in
            switch result {
            case .success(let currencies):
                self?.currencies = currencies.compactMap { try? Currecy(code: $0.key, name: $0.value) }.sorted(by: { $0.code < $1.code })
                self?.delegate?.onListCurrencies()
                
            case .failure(let error):
                self?.delegate?.onError(error)
            }
        }
    }
}
