//
//  MainInteractor.swift
//  BTG Converser
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class MainInteractor {

    unowned private let presenter: MainPresenterToInteractor

    init (presenter: MainPresenterToInteractor) {
        self.presenter = presenter
    }

    private let taxsPath = "/live"
    private let currenciesPath = "/list"

    private func getLastUpdateDate() {
        self.presenter.failToFetchDataInAPI(lastUpdate: LocalData.instance.apiLastUpdateDate)
    }

    private func fetchTaxes() {
        API.instance.get(path: self.taxsPath) { [weak self] (data, _, error) in
            if let error = error {
                debugPrint(error)
                self?.getLastUpdateDate()
                return
            }

            guard let data = data else {
                self?.getLastUpdateDate()
                return
            }

            do {
                let res = try JSONDecoder().decode(TaxesResponse.self, from: data)
                self?.saveTaxesResponse(res)
            } catch let error {
                debugPrint(error)
                self?.getLastUpdateDate()
            }
        }
    }

    private func saveTaxesResponse(_ response: TaxesResponse) {
        for quote in response.quotes {
            let fromCode = String(quote.key.prefix(3))
            let toCode = String(quote.key.suffix(3))
            TaxModel.createOrUpdate(fromCode: fromCode, toCode: toCode, value: quote.value)
        }

        self.fetchCurrencies()
   }

    private func fetchCurrencies() {
        API.instance.get(path: self.currenciesPath) { [weak self] (data, _, error) in
            if let error = error {
                debugPrint(error)
                self?.getLastUpdateDate()
                return
            }

            guard let data = data else {
                self?.getLastUpdateDate()
                return
            }

            do {
                let res = try JSONDecoder().decode(CurrenciesResponse.self, from: data)
                self?.saveCurrenciesResponse(res)
            } catch let error {
                debugPrint(error)
                self?.getLastUpdateDate()
            }
        }
    }

    private func saveCurrenciesResponse(_ response: CurrenciesResponse) {
        for currency in response.currencies {
            CurrencyModel.createOrUpdate(code: currency.key, name: currency.value)
        }

        LocalData.instance.apiLastUpdateDate = Date()
        self.presenter.successOnFetchDataInAPI()
    }

}

// MARK: - MainInteractorToPresenter

extension MainInteractor: MainInteractorToPresenter {

    func fetchTaxesAndCurrenciesInAPI() {
        self.fetchTaxes()
    }

    func convertValue(_ value: Double, from fromCode: String, to toCode: String) {
        if let valueConverted = CurrencyConverter(fromCode: fromCode, toCode: toCode).convertValue(value) {
            self.presenter.didConvertValue(valueConverted)
        } else {
            self.presenter.didFailConverValue()
        }
    }

}
