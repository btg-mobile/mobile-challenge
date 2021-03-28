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
    private var firstCurrency: Currency?
    private var secondCurrency: Currency?

    // MARK: - Initializers
    init(mainViewModel: MainViewModel) {
        self.viewModel = mainViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overrides
    override func viewDidLoad() {
        self.title = StringsDictionary.currencyConverter
        self.setupComponents()
        super.viewDidLoad()
    }

    // MARK: - Private Methods
    private func setupComponentsGestures() {
        let firstGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapOnCurrencyComponent))
        let secondGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapOnSecondCurrencyComponent))
        self.firstCurrencyComponent.addGestureRecognizer(firstGesture)
        self.secondCurrencyComponent.addGestureRecognizer(secondGesture)
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
        self.viewModel.presentCurrencySelector(order: .first, selectedCurrency: { [weak self] currency in
            self?.firstCurrency = currency
            self?.firstCurrencyComponent.setCurrency(currency: currency)
        })
    }

    @objc private func tapOnSecondCurrencyComponent() {
        self.viewModel.presentCurrencySelector(order: .second, selectedCurrency: { [weak self] currency in
            self?.secondCurrency = currency
            self?.secondCurrencyComponent.setCurrency(currency: currency)
        })
    }
}

