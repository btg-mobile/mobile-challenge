//
//  CurrenciesCoordinator.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 03/11/20.
//

import UIKit

protocol CurrenciesViewControllerDelegate: class {
    func didSelectedCurrency()
    func returnToExchangesView()
}

final class CurrenciesCoordinator: Coordinator {
    
    var presenter: UINavigationController
    private var currenciesViewController: CurrenciesViewController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        currenciesViewController = CurrenciesViewController()
        currenciesViewController.coordinator = self
    }
    
    func start() {
        presenter.present(currenciesViewController, animated: true)
    }
}

extension CurrenciesCoordinator: CurrenciesViewControllerDelegate {

    func returnToExchangesView() {
        presenter.dismiss(animated: true)
    }
    
    func didSelectedCurrency() {
        presenter.dismiss(animated: true)
    }
}
