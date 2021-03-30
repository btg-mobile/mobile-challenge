//
//  MainViewController.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var firstCurrencyComponent: CurrencyComponent!
    @IBOutlet private weak var secondCurrencyComponent: CurrencyComponent!

    // MARK: - Attributes
    private var viewModel: MainViewModel
    private var updateCurrencies: () -> Void = {}

    // MARK: - Initializers
    init(mainViewModel: MainViewModel) {
        self.viewModel = mainViewModel
        super.init(nibName: nil, bundle: nil)
        self.updateCurrencies = {
            self.firstCurrencyComponent.setCurrency(currency: self.viewModel.firstCurrency)
            self.secondCurrencyComponent.setCurrency(currency: self.viewModel.secondCurrency)
            self.secondCurrencyComponent.valueTextField.text = "\(self.viewModel.convertedValue)"
        }
        self.viewModel.updateCurrencies = self.updateCurrencies
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overrides
    override func viewDidLoad() {
        self.title = StringsDictionary.currencyConverter
        self.setupComponents()
        self.updateCurrencies()
        super.viewDidLoad()
    }

    // MARK: - Private Methods
    private func setupComponentsGestures() {
        let firstGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapOnCurrencyComponent))
        let secondGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapOnSecondCurrencyComponent))
        self.firstCurrencyComponent.addGestureRecognizer(firstGesture)
        self.secondCurrencyComponent.addGestureRecognizer(secondGesture)
        self.firstCurrencyComponent.valueTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }

    private func setupComponents() {
        self.firstCurrencyComponent.valueTextField.becomeFirstResponder()
        self.secondCurrencyComponent.iconLabel.textColor = UIColor(red: 144/255, green: 82/255, blue: 80/255, alpha: 1)
        self.secondCurrencyComponent.iconView.backgroundColor = UIColor(red: 248/255, green: 214/255, blue: 214/255, alpha: 1)
        self.secondCurrencyComponent.valueTextField.isEnabled = false
        self.setupComponentsGestures()
    }

    // MARK: - Objc Methods
    @objc private func tapOnCurrencyComponent() {
        self.viewModel.presentCurrencySelector(order: .first)
    }

    @objc private func tapOnSecondCurrencyComponent() {
        self.viewModel.presentCurrencySelector(order: .second)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        if let value: Double = Double(textField.text ?? "") {
            self.viewModel.convertValueToCurrency(valueToConvert: value)
        }
    }
}
