//
//  ExchangeCoordinator.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 03/11/20.
//

import UIKit

protocol ExchangeViewControllerDelegate: class {
    func goToCurrencies(callerButtonTag: Int)
}

final class ExchangeCoordinator: Coordinator {
    
    var presenter: UINavigationController
    private var exchangeViewController: ExchangeViewController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.exchangeViewController = ExchangeViewController()
        self.exchangeViewController.coordinator = self
    }
    
    func start() {
        presenter.pushViewController(exchangeViewController, animated: true)
    }
}

extension ExchangeCoordinator: ExchangeViewControllerDelegate {
    
    func goToCurrencies(callerButtonTag: Int) {
        let currenciesCoordinator = CurrenciesCoordinator(presenter: presenter, callerButtonTag: callerButtonTag)
        currenciesCoordinator.start()
    }
}
