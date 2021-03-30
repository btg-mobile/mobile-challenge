//
//  MainViewModel.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

class MainViewModel: GenericModel {

    // MARK: - Attributes
    var updateCurrencies: () -> Void = {}
    private var repository: CurrencyRepositoryProtocol
    private var currenciesRate: [CurrencyRate] = []
    var firstCurrency: Currency? {
        didSet {
            self.updateCurrencies()
        }
    }
    var secondCurrency: Currency? {
        didSet {
            self.updateCurrencies()
            self.getCurrencyValue()
        }
    }

    // MARK: - Initializer
    init(currencyRepository: CurrencyRepositoryProtocol) {
        self.repository = currencyRepository
        super.init()
        self.getCurrenciesRate()
    }

    // MARK: - Private Methods
    private func getCurrenciesRate() {
        self.repository.getCurrenciesRate { [weak self] result in
            switch result {
            case .success(let currencyRateObject):
                self?.currenciesRate = currencyRateObject.currenciesRate
            case .failure(_):
                print("ERROR")
            }
        }
    }

    private func getCurrencyValue() {
        if !self.currenciesRate.isEmpty, let firstCurrency = self.firstCurrency, let secondCurrency = self.secondCurrency {
            let firstCurrencyCode: String = "USD\(firstCurrency.code)"
            let secondCurrencyCode: String = "USD\(secondCurrency.code)"
            if let firstTax = self.currenciesRate.first(where: { $0.source == firstCurrencyCode }), let secondTax = self.currenciesRate.first(where: { $0.source == secondCurrencyCode }) {
                let a = firstTax.value * secondTax.value
                print("\(firstTax.value * secondTax.value)")
            }
            print("")
        } else {
            return
        }
    }

    // MARK: - Public Methods
    func presentMain() {
        self.router.present()
    }

    func presentCurrencySelector(order: CurrencyOrder) {
        if let router = self.router as? MainRouter {
            router.presentCurrencysView(order: order, selectedCurrency: { currency in
                switch order {
                case .first:
                    self.firstCurrency = currency
                case .second:
                    self.secondCurrency = currency
                }
            })
        }
    }
}
