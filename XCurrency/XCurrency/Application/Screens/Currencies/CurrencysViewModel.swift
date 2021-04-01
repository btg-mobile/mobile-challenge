//
//  CurrencysViewModel.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

import Foundation

class CurrencysViewModel: GenericModel {
    
    // MARK: - Attributes
    var updateCurrencies: () -> Void = { }
    private var orderBy: CurrenciesOrder = .name
    private var repository: CurrencyRepositoryProtocol
    private var currencies = [Currency]()
    private var filteredCurrencies = [Currency]() {
        didSet {
            DispatchQueue.main.async {
                self.updateCurrencies()
            }
        }
    }
    
    // MARK: - Initializer
    init(currencyRepository: CurrencyRepositoryProtocol) {
        self.repository = currencyRepository
        super.init()
        self.getUpdatedCurrencies()
    }
    
    // MARK: - Private Methods
    private func getUpdatedCurrencies() {
        self.repository.getCurrencyList { [weak self] result in
            switch result {
            case .success(let currenciesObject):
                if let self = self {
                    self.currencies = self.getCurrenciesSortedBy(order: self.orderBy, currencies: currenciesObject.currencies)
                    self.filteredCurrencies = self.currencies
                }
            case .failure(_):
                print("ERROR")
            }
        }
    }
    
    private func getCurrenciesSortedBy(order: CurrenciesOrder, currencies: [Currency]) -> [Currency] {
        var currenciesSorted: [Currency] = []
        switch order {
        case .code:
            currenciesSorted = currencies.sorted(by: {$0.code < $1.code})
        case .name:
            currenciesSorted = currencies.sorted(by: {$0.name < $1.name})
        }
        return currenciesSorted
    }
    
    // MARK: - Public Methods
    func orderCurrenciesBy(_ order: CurrenciesOrder) {
        self.orderBy = order
        switch order {
        case .code:
            self.filteredCurrencies = self.filteredCurrencies.sorted(by: {$0.code < $1.code})
        case .name:
            self.filteredCurrencies = self.filteredCurrencies.sorted(by: {$0.name < $1.name})
        }
    }
    
    func filterCurrenciesBy(text: String) {
        if text.isEmpty {
            self.filteredCurrencies = self.getCurrenciesSortedBy(order: self.orderBy, currencies: self.currencies)
        } else {
            self.filteredCurrencies = self.currencies.filter { $0.name.lowercased().contains(text.lowercased()) || $0.code.lowercased().contains(text.lowercased())
            }
        }
    }
    
    func presentCurrencys() {
        self.router.present()
    }
    
    func getCurrencies() -> [Currency] {
        return self.filteredCurrencies
    }
    
    func getCurrency(position: Int) -> Currency? {
        return position <= (filteredCurrencies.count - 1) ? self.filteredCurrencies[position] : nil
    }
    
    func dismiss() {
        self.router.dismiss()
    }
}
