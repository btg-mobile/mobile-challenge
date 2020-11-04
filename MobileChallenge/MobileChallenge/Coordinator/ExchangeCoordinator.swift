//
//  ExchangeCoordinator.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 03/11/20.
//

import UIKit

protocol ExchangeViewControllerDelegate: class {
    func goToCurrenciesList()
}

final class ExchangeCoordinator: Coordinator {
    
    var presenter: UINavigationController
    private var exchangeViewController: ExchangeViewController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.exchangeViewController = ExchangeViewController()
        
        exchangeViewController.coordinator = self
    }
    
    func start() {
        presenter.pushViewController(exchangeViewController, animated: true)
    }
}

extension ExchangeCoordinator: ExchangeViewControllerDelegate {
    
    func goToCurrenciesList() {
        let currenciesCoordinator = CurrenciesCoordinator(presenter: presenter)
        currenciesCoordinator.start()
    }
}
