//
//  ViewController.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import UIKit

class ExchangeViewController: UIViewController {

    private let exchangeView = ExchangeView()
    private var buttonPressed: ButtonType?
    private let exchangeViewModel = ExchangeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.addSubview(exchangeView)
        view.backgroundColor = .systemBackground
        setupConstraints()
        setupClosures()
    }
    
    private func setupClosures() {
        let showCurrencyVC: (ButtonType?) -> Void = { [weak self] buttonType in
            self?.buttonPressed = buttonType
            let currencyListVC = CurrencyListViewController()
            currencyListVC.selectDelegate = self
            self?.present(currencyListVC, animated: true, completion: nil)
        }
        
        exchangeView.fromStackView.selectCurrency = showCurrencyVC
        exchangeView.toStackView.selectCurrency = showCurrencyVC
        
        exchangeView.fromStackView.convertCurrency = { [weak self] value in
            self?.exchangeView.toStackView.valueTextField.text = self?.exchangeViewModel.convertCurrencies(value: value)
        }
    }

    private func setupConstraints(){
        NSLayoutConstraint.activate([
            exchangeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exchangeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            exchangeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            exchangeView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

extension ExchangeViewController: SelectCurrencyDelegate {
    func getCurrency(currency: CurrencyModel) {
        switch buttonPressed {
        case .from:
            exchangeView.fromStackView.currencyButton.setTitle(currency.name, for: .normal)
            exchangeViewModel.fromCurrency = currency
        case .to:
            exchangeView.toStackView.currencyButton.setTitle(currency.name, for: .normal)
            exchangeViewModel.toCurrency = currency
        case .none:
            buttonPressed = nil
        }
    }
}
