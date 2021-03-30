//
//  CurrencysViewModel.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

import Foundation

class CurrencysViewModel: GenericModel {

    // MARK: - Attributes
    private var repository: CurrencyRepositoryProtocol
    var updateCurrencies: () -> Void = { }
    private var currencies = [Currency]() {
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
                self?.currencies = currenciesObject.currencies.sorted(by: {$0.name < $1.name})
            case .failure(_):
                print("ERROR")
            }
        }
    }

    // MARK: - Public Methods
    func orderCurrenciesBy(_ order: CurrenciesOrder) {
        switch order {
        case .code:
            self.currencies = self.currencies.sorted(by: {$0.code < $1.code})
        case .name:
            self.currencies = self.currencies.sorted(by: {$0.name < $1.name})
        }
    }

    func presentCurrencys() {
        self.router.present()
    }

    func getCurrencies() -> [Currency] {
        return self.currencies
    }

    func getCurrency(position: Int) -> Currency? {
        return position <= (currencies.count - 1) ? self.currencies[position] : nil
    }

    func dismiss() {
        self.router.dismiss()
    }
}

enum CurrenciesOrder {
    case name, code
}
