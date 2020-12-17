//
//  CurrencyTextField.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 17/12/20.
//

import UIKit

@propertyWrapper class CurrencyTextField<T: UITextField> {
    private lazy var textField: T = {
        let textField = T(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .right
        textField.adjustsFontSizeToFitWidth = true
        textField.keyboardType = .decimalPad
        textField.inputAccessoryView = inputAccessoryView
        textField.layer.borderWidth = 1
        textField.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)

        return textField
    }()

    private var inputAccessoryView: UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemBackground
        return view
    }

    @objc private func dismissKeyboard() {
        wrappedValue.endEditing(true)
    }

    var wrappedValue: T {
        return textField
    }
}
