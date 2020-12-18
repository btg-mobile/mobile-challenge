//
//  CurrencyTextField.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 17/12/20.
//

import UIKit

@propertyWrapper class CurrencyTextField<T: PaddingTextField> {
    private let formatter = NumberFormatter()

    private lazy var textField: T = {
        let textField = T()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .right
        textField.adjustsFontSizeToFitWidth = true
        textField.keyboardType = .decimalPad
        textField.layer.borderWidth = DesignSystem.TextField.borderWidth
        textField.layer.borderColor = DesignSystem.Colors.border.cgColor
        textField.layer.cornerRadius = DesignSystem.TextField.cornerRadius
        textField.inputAccessoryView = inputAccessoryView
        textField.clearButtonMode = .whileEditing
        textField.font = UIFont.systemFont(ofSize: DesignSystem.FontSize.large)

        textField.addSubview(currencyCodeView)

        formatter.numberStyle = .currency
        textField.placeholder = formatter.string(from: 0)?.replacingOccurrences(of: formatter.currencySymbol, with: "")

        return textField
    }()

    private lazy var currencyCodeView: UIView = {
        let view = UIView(frame: DesignSystem.CurrencyCodeView.frame)
        view.backgroundColor = DesignSystem.Colors.currencyCodeView
        view.layer.cornerRadius = DesignSystem.CurrencyCodeView.cornerRadius

        view.addSubview(currencyCodeLabel)
        NSLayoutConstraint.activate([
            currencyCodeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currencyCodeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        return view
    }()

    private lazy var currencyCodeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: DesignSystem.FontSize.large)

        return label
    }()

    private var inputAccessoryView: UIView {
        let blurEffect = UIBlurEffect(style: .prominent)

        let view = UIVisualEffectView(effect: blurEffect)
        view.frame = DesignSystem.InputAccessoryView.frame

        let button = InputAccessoryViewButton(frame: DesignSystem.InputAccessoryViewButton.frame)
        button.setTitle(LiteralText.done, for: .normal)
        button.setTitleColor(DesignSystem.Colors.action, for: .normal)
        button.addTarget(self, action: #selector(dismissKeyboard), for: .touchUpInside)

        view.contentView.addSubview(button)

        return view
    }

    @objc private func dismissKeyboard() {
        wrappedValue.endEditing(true)
    }

    func setCurrencyCode(_ code: String) {
        currencyCodeLabel.text = code
    }

    var wrappedValue: T {
        return textField
    }
}
