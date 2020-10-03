//
//  CurrencyConverterViewModel.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 01/10/20.
//

import Foundation

/// The protocol responsible for establishing a communication path
/// between `CurrencyConverterViewModel` and `CurrencyViewController`.
protocol CurrencyConverterViewModelDelegate: AnyObject {
    /// Updates the UI of the View.
    func updateUI()
}

/// The `ViewModel` responsible for `CurrencyConverterViewController`.
final class CurrencyConverterViewModel {
    //- MARK: Properties
    /// The delegate responsible for `ViewModel -> View` binding.
    weak var delegate: CurrencyConverterViewModelDelegate?

    /// The manager responsible for network calls.
    private let networkManager: NetworkManager

    /// The `Coordinator` associated with this `ViewModel`.
    private let coordinator: CurrencyConverterCoordinator

    //- MARK: Init
    /// Initializes a new instance of this type.
    /// - Parameter networkManager: The manager responsible for network calls.
    init(networkManager: NetworkManager, coordinator: CurrencyConverterCoordinator) {
        self.networkManager = networkManager
        self.coordinator = coordinator
    }

    //- MARK: API
    /// The amount to be converted.
    var amount: String = "" {
        didSet {
            convertedAmount = convert(amount)
            delegate?.updateUI()
        }
    }

    /// The converted amount.
    var convertedAmount: String = ""

    /// Warns `Coordinator` to navigate to the currency picker screen.
    /// - Parameter case: The currency case picked by the user.
    func pickCurrency(_ case: CurrencyPickingCase) {
        coordinator.pickCurrency(`case`)
    }

    //- MARK: Private
    private func convert(_ amount: String) -> String {
        guard let amountDouble = Double(amount) else {
            return ""
        }
        let converted = amountDouble * 5.47
        return String(format: "%.2f", converted)
    }

}
