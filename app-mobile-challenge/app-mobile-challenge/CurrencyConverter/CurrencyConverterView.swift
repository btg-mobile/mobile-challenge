//
//  CurrencyConverterView.swift
//  app-mobile-challenge
//
//  Created by Matheus Gois on 12/06/21.
//

import UIKit

// Protocols

protocol CurrencyConverterViewDelegate: AnyObject {
    var currencyValueIsEmpty: Bool { get }
    func updateValue(_ value: String)
}

// Class

class CurrencyConverterView: UIView {

    // Views

    @AutoLayout var currencyButton: SupportedButton
    @AutoLayout var fromCurrencyLabel: CurrencyResultLabel
    @AutoLayout var fromCurrencyButton: CurrentyButton
    @AutoLayout var toCurrencyLabel: CurrencyResultLabel
    @AutoLayout var toCurrencyButton: CurrentyButton
    @AutoLayout var calculationButton: CalculationButton

    private(set) lazy var keyboard: KeyboardView = KeyboardView(
        frame: frame,
        delegate: self
    )

    // Properties

    weak var delegate: CurrencyConverterViewDelegate?

    // Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Setup

    func setup(delegate: CurrencyConverterViewDelegate) {
        self.delegate = delegate
        layoutConstraints()
    }
    
}

// Methods

private extension CurrencyConverterView {
    func layoutConstraints() {
        layoutButton()
        layoutFromCurrenty()
        layoutToCurrenty()
        layoutCalculationButton()
        layoutToKeyboard()
    }
}

// Build Layout

extension CurrencyConverterView {

    private func layoutButton() {
        addSubview(currencyButton)

        let layoutGuides = layoutMarginsGuide

        NSLayoutConstraint.activate([
            currencyButton.topAnchor.constraint(equalTo: layoutGuides.topAnchor, constant: DesignSystem.Spacing.large),
            currencyButton.leadingAnchor.constraint(equalTo: layoutGuides.leadingAnchor),
            currencyButton.heightAnchor.constraint(equalToConstant: DesignSystem.Button.height),
            currencyButton.widthAnchor.constraint(equalToConstant: DesignSystem.Button.width)
        ])
    }

    private func layoutFromCurrenty() {
        addSubview(fromCurrencyLabel)
        addSubview(fromCurrencyButton)

        let layoutGuides = layoutMarginsGuide

        NSLayoutConstraint.activate([
            fromCurrencyButton.topAnchor.constraint(equalTo: currencyButton.bottomAnchor, constant: DesignSystem.Spacing.large),
            fromCurrencyButton.trailingAnchor.constraint(equalTo: layoutGuides.trailingAnchor),
            fromCurrencyButton.heightAnchor.constraint(equalToConstant: DesignSystem.Button.Currency.height),
            fromCurrencyButton.widthAnchor.constraint(equalToConstant: DesignSystem.Button.Currency.width),


            fromCurrencyLabel.topAnchor.constraint(equalTo: fromCurrencyButton.topAnchor),
            fromCurrencyLabel.trailingAnchor.constraint(equalTo: fromCurrencyButton.leadingAnchor),
            fromCurrencyLabel.heightAnchor.constraint(equalToConstant: DesignSystem.Button.Currency.height),
            fromCurrencyLabel.widthAnchor.constraint(equalTo: layoutGuides.widthAnchor, multiplier: DesignSystem.Button.Currency.widthLabelMultiplier),
        ])
    }

    private func layoutToCurrenty() {
        addSubview(toCurrencyLabel)
        addSubview(toCurrencyButton)

        let layoutGuides = layoutMarginsGuide

        NSLayoutConstraint.activate([
            toCurrencyButton.topAnchor.constraint(equalTo: fromCurrencyButton.bottomAnchor),
            toCurrencyButton.trailingAnchor.constraint(equalTo: layoutGuides.trailingAnchor),
            toCurrencyButton.heightAnchor.constraint(equalToConstant: DesignSystem.Button.Currency.height),
            toCurrencyButton.widthAnchor.constraint(equalToConstant: DesignSystem.Button.Currency.width),


            toCurrencyLabel.topAnchor.constraint(equalTo: toCurrencyButton.topAnchor),
            toCurrencyLabel.trailingAnchor.constraint(equalTo: toCurrencyButton.leadingAnchor),
            toCurrencyLabel.heightAnchor.constraint(equalToConstant: DesignSystem.Button.Currency.height),
            toCurrencyLabel.widthAnchor.constraint(equalTo: layoutGuides.widthAnchor, multiplier: DesignSystem.Button.Currency.widthLabelMultiplier),
        ])
    }

    private func layoutToKeyboard() {
        addSubview(keyboard)
        let layoutGuides = layoutMarginsGuide
        NSLayoutConstraint.activate([
            keyboard.bottomAnchor.constraint(
                equalTo: calculationButton.topAnchor,
                constant: DesignSystem.Keyboard.Layout.top),
            keyboard.centerXAnchor.constraint(equalTo: layoutGuides.centerXAnchor),
            keyboard.heightAnchor.constraint(equalToConstant: DesignSystem.Keyboard.height),
            keyboard.widthAnchor.constraint(equalToConstant: DesignSystem.Keyboard.width),
        ])
    }

    private func layoutCalculationButton() {
        addSubview(calculationButton)
        let layoutGuides = layoutMarginsGuide

        NSLayoutConstraint.activate([
            calculationButton.bottomAnchor.constraint(
                equalTo: layoutGuides.bottomAnchor,
                constant: DesignSystem.Keyboard.Layout.top),
            calculationButton.centerXAnchor.constraint(equalTo: layoutGuides.centerXAnchor),
            calculationButton.heightAnchor.constraint(equalToConstant: DesignSystem.Keyboard.Layout.height),
            calculationButton.widthAnchor.constraint(equalTo: layoutGuides.widthAnchor, multiplier: DesignSystem.Keyboard.Layout.widthMultiplier),
        ])
    }
}

// KeyboardViewService

extension CurrencyConverterView: KeyboardViewService {
    func selected(value: String) {
        fromCurrencyLabel.text = value
        delegate?.updateValue(value)
        if delegate?.currencyValueIsEmpty == true {
            fromCurrencyLabel.text = "1,00"
        }
    }
}
