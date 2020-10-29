//
//  ExchangeCoordinator.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import UIKit



final class ExchangeCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var presenter: UINavigationController
    private let exchangeViewController: ExchangeViewController
    private let exchangeViewModel: ExchangeViewModel
    private let currencyListCoordinator: CurrencyListCoordinator

    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.exchangeViewModel = ExchangeViewModel()
        self.exchangeViewController = ExchangeViewController(viewModel: exchangeViewModel)
        self.currencyListCoordinator = CurrencyListCoordinator(presenter: presenter)
        self.exchangeViewController.coordinator = self

    }
    
    // MARK: - Methods
    
    func start() {
        self.presenter.pushViewController(exchangeViewController, animated: true)
    }
    
    
}

// MARK: - Exchange Delegate

extension ExchangeCoordinator: ExchangeViewControllerDelegate {
    
    func presentCurrencyList() {
        self.currencyListCoordinator.start()
    }
    
}
