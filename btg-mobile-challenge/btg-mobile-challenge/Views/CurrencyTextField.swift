//
//  CurrencyTextField.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 01/10/20.
//

import UIKit

final class CurrencyTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        styleTextField()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func styleTextField() {
        keyboardType = .numberPad
        textAlignment = .center
        borderStyle = .roundedRect
    }
}
