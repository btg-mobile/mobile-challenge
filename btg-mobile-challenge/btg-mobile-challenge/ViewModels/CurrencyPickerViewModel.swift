//
//  CurrencyPickerViewModel.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 03/10/20.
//

import Foundation

protocol CurrencyListViewModelDelegate: AnyObject {
    func didSelectCurrency(_ new: IndexPath, previous: IndexPath)
}

final class CurrencyPickerViewModel {

    //- MARK: Properties
    weak var delegate: CurrencyListViewModelDelegate?

    @UserDefaultAccess(key: CurrencyPickingCase.from.rawValue, defaultValue: "USD")
    private var fromCurrency: String

    @UserDefaultAccess(key: CurrencyPickingCase.to.rawValue, defaultValue: "BRL")
    private var toCurrency: String

    private let coordinator: CurrencyConverterCoordinator

    private let `case`: CurrencyPickingCase

    private var currencies: [[Currency]] = [Currency.generate(30)] {
        didSet {

        }
    }

    init(coordinator: CurrencyConverterCoordinator, case: CurrencyPickingCase) {
        self.coordinator = coordinator
        self.case = `case`
        self.currentCurrency = IndexPath(row: 0, section: 0)
        switch `case` {
        case .from:
            self.title = "From"
        case .to:
            self.title = "To"
        }
    }

    let title: String

    var currentCurrency: IndexPath {
        didSet {
            switch `case` {
            case .from:
                fromCurrency = currencies[currentCurrency.section][currentCurrency.row].code
            case .to:
                toCurrency = currencies[currentCurrency.section][currentCurrency.row].code
            }
            delegate?.didSelectCurrency(currentCurrency, previous: oldValue)
        }
    }

    var numberOfSections: Int {
        return currencies.count
    }

    func numberOfRows(in section: Int) -> Int {
        return currencies[section].count
    }

    func currencyCodeAt(index: IndexPath) -> String {
        return currencies[index.section][index.row].code
    }

    func nameCodeAt(index: IndexPath) -> String {
        return currencies[index.section][index.row].name
    }

}
