//
//  CurrencyConverterViewModel.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 01/10/20.
//

import Foundation

protocol CurrencyConverterViewModelDelegate: AnyObject {
    func updateUI()
}

final class CurrencyConverterViewModel {

    weak var delegate: CurrencyConverterViewModelDelegate?

    init() {

    }

    var amount: String = "" {
        didSet {
            convertedAmount = amount
            delegate?.updateUI()
        }
    }

    var convertedAmount: String = ""

}
