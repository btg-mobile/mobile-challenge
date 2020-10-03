//
//  CurrencyListViewModel.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 03/10/20.
//

import Foundation

protocol CurrencyListViewModelDelegate: AnyObject {
    func didSelectCurrency(_ new: IndexPath, previous: IndexPath)
}

final class CurrencyPickerViewModel {
    //- MARK: Case
    enum Case: String {
        case from = "from-currency"
        case to = "to-currency"
    }

    //- MARK: Properties
    weak var delegate: CurrencyListViewModelDelegate?

    private let coordinator: CurrencyConverterCoordinator

    private let `case`: Case

    private var currencies: [[Currency]] = [Currency.generate(30)] {
        didSet {

        }
    }

    init(coordinator: CurrencyConverterCoordinator, case: CurrencyPickerViewModel.Case) {
        self.coordinator = coordinator
        self.case = `case`
        self.currentCurrency = IndexPath(row: 0, section: 0)
    }

    var currentCurrency: IndexPath {
        didSet {
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
