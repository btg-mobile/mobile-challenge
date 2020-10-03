//
//  CurrencyPickerViewModel.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 03/10/20.
//

import Foundation

/// The protocol responsible for establishing a communication path
/// between `CurrencyPickerViewModel` and `CurrencyPickerViewController`.
protocol CurrencyListViewModelDelegate: AnyObject {
    /// Informs the delegate to update its selected currency.
    func didSelectCurrency(_ new: IndexPath, previous: IndexPath)
}

/// The `ViewModel` responsible for `CurrencyPickerViewController`.
final class CurrencyPickerViewModel {
    //- MARK: Properties
    /// The delegate responsible for `ViewModel -> View` binding.
    weak var delegate: CurrencyListViewModelDelegate?

    @UserDefaultAccess(key: CurrencyPickingCase.from.rawValue, defaultValue: "USD")
    private var fromCurrency: String

    @UserDefaultAccess(key: CurrencyPickingCase.to.rawValue, defaultValue: "BRL")
    private var toCurrency: String

    /// The `Coordinator` associated with this `ViewModel`.
    private let coordinator: CurrencyConverterCoordinator

    /// The currency case of this `ViewModel`.
    private let `case`: CurrencyPickingCase

    /// The list of supported currencies.
    private var currencies: [[Currency]] = [Currency.generate(30)] {
        didSet {

        }
    }

    //- MARK: Init
    /// Initializes a new instance of this type.
    /// - Parameter coordinator: The `Coordinator` associated with this `ViewModel`.
    /// - Parameter case: The currency case of this `ViewModel`.
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

    //- MARK: API
    /// The title of the `View`.
    let title: String

    /// The currently selected currency.
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

    /// The number of sections to be displayed in the `View`.
    var numberOfSections: Int {
        return currencies.count
    }

    /// Returns the number of rows to be displayed in a given section.
    /// - Parameter section: The section in the `View`.
    func numberOfRows(in section: Int) -> Int {
        return currencies[section].count
    }

    /// Returns a currency's code at a given `IndexPath`.
    /// - Parameter index: The `IndexPath` of a currency.
    func currencyCodeAt(index: IndexPath) -> String {
        return currencies[index.section][index.row].code
    }

    /// Returns a currency's name at a given `IndexPath`.
    /// - Parameter index: The `IndexPath` of a currency.
    func nameCodeAt(index: IndexPath) -> String {
        return currencies[index.section][index.row].name
    }

}
