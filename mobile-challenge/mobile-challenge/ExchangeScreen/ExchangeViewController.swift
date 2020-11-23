//
//  ViewController.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import UIKit

class ExchangeViewController: UIViewController {

    private let exchangeView = ExchangeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.addSubview(exchangeView)
        view.backgroundColor = .systemBackground
        setupConstraints()
        setupClosures()
    }
    
    private func setupClosures() {
        let showCurrencyVC = { [weak self] in
            let currencyListVC = CurrencyListViewController()
            currencyListVC.selectDelegate = self
            self?.present(currencyListVC, animated: true, completion: nil)
        }
        
        exchangeView.fromStackView.selectCurrency = showCurrencyVC
        exchangeView.toStackView.selectCurrency = showCurrencyVC
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
        
    }
}

