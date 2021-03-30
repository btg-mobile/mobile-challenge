//
//  MainViewModel.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

class MainViewModel: GenericModel {

    // MARK: - Attributes
    private var repository: CurrencyRepositoryProtocol
    private var currenciesRate: [CurrencyRate] = []
    var updateCurrencies: () -> Void = {}
    var convertedValue: Double = 0
    var firstCurrency: Currency? {
        didSet {
            self.updateCurrencies()
        }
    }
    var secondCurrency: Currency? {
        didSet {
            self.updateCurrencies()
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

    private func convertCurrencyToCurrency(firstCurrencyCode: String, secondCurrencyCode: String, valueToConvert: Double) {
        if let firstTax = self.currenciesRate.first(where: { $0.source == firstCurrencyCode }), let secondTax = self.currenciesRate.first(where: { $0.source == secondCurrencyCode }){
            self.convertedValue = (valueToConvert/firstTax.value) * secondTax.value
            self.updateCurrencies()
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

    func convertValueToCurrency(valueToConvert: Double) {
        if let firstCurrency = self.firstCurrency, let secondCurrency = self.secondCurrency {
            let firstCode: String = "USD\(firstCurrency.code)"
            let secondCode: String = "USD\(secondCurrency.code)"
            self.convertCurrencyToCurrency(firstCurrencyCode: firstCode, secondCurrencyCode: secondCode, valueToConvert: valueToConvert)
        }
    }
}
