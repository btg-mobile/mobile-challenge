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

    private var currencies = [Currency]()
    private var showingCurrencies = [Currency]() {
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
                guard let self = self else { return }
                self.currencies = currencyList.currencies.sorted { $0.name < $1.name }
                self.showingCurrencies = self.currencies
            case .failure(let error):
                print(error)
            }
        }
    }

    func sort(by segmentIndex: Int) {
        let filterType = FilterType(rawValue: segmentIndex)

        switch filterType {
        case .name:
            showingCurrencies.sort { $0.name < $1.name }
        case .code:
            showingCurrencies.sort { $0.code < $1.code }
        default:
            return
        }
    }

    func getCurrency(for index: Int) -> Currency {
        return showingCurrencies[index]
    }

    func getCurrenciesSize() -> Int {
        return showingCurrencies.count
    }

    func filter(by text: String) {
        if text.isEmpty {
            showingCurrencies = currencies
        } else {
            showingCurrencies = currencies.filter {
                $0.name.contains(text) || $0.code.contains(text)
            }
        }
    }
}
