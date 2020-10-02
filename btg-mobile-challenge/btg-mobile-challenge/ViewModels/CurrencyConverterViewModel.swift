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

/// The ViewModel responsible for `CurrencyConverterViewController`.
final class CurrencyConverterViewModel {
    //- MARK: Properties
    /// The delegate responsible for `ViewModel -> View communication`.
    weak var delegate: CurrencyConverterViewModelDelegate?

    //- MARK: Init
    /// Initializes a new instance of this type.
    init() {

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

    //- MARK: Private
    private func convert(_ amount: String) -> String {
        guard let amountDouble = Double(amount) else {
            return ""
        }
        let converted = amountDouble * 5.47
        return String(format: "%.2f", converted)
    }

}
