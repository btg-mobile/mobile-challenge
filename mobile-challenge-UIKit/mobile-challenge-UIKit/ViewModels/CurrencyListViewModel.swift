//
//  CurrencyListViewModel.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 18/12/20.
//

import Foundation

class CurrencyListViewModel {

    enum FilterType: Int {
        case name
        case code
    }

    private var service: CurrencyListProviding
    private var onUpdate: () -> Void

    private(set) var currencies = [Currency]() {
        didSet {
            DispatchQueue.main.async {
                self.onUpdate()
            }
        }
    }

    init(service: CurrencyListProviding, onUpdate: @escaping () -> Void) {
        self.service = service
        self.onUpdate = onUpdate
        getCurrencyList()
    }

    private func getCurrencyList() {
        service.getCurrencyList { [weak self] result in
            switch result {
            case .success(let currencyList):
                self?.currencies = currencyList.currencies
            case .failure(let error):
                print(error)
            }
        }
    }

    func sort(by segmentIndex: Int) {
        let filterType = FilterType(rawValue: segmentIndex)

        switch filterType {
        case .name:
            currencies.sort { $0.name < $1.name }
        case .code:
            currencies.sort { $0.code < $1.code }
        default:
            return
        }
    }
}
