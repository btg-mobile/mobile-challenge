//
//  MainCoordinator.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 08/12/20.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = ExchangeViewController.instantiate(from: UIStoryboard.Name.exchangeScreen)
        let viewModel = ExchangeViewModel(currencyRates: RealtimeRates.init(timestamp: 0, quotes: ["": 0]), service: CurrencyLayerAPI())

        viewController?.coordinator = self
        viewController?.viewModel = viewModel
        navigationController.pushViewController(viewController!, animated: true)
    }

    // MARK: - Navigation Functions
    func goToExchangeScreen(with viewModel: ExchangeViewModel) {
        let viewController = ExchangeViewController.instantiate(from: UIStoryboard.Name.exchangeScreen)
        viewController?.coordinator = self
        viewController?.viewModel = viewModel
        navigationController.popViewController(animated: true)
    }

    func goToCurrenciesScreen() {
        let viewController = CurrenciesViewController.instantiate(from: UIStoryboard.Name.currenciesScreen)
        viewController?.coordinator = self
        navigationController.pushViewController( viewController!, animated: true)
    }
}
