//
//  QuotationCoordinator.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 25/11/20.
//

import UIKit

class QuotationCoordinator: Coordinator {
    var navigationController: UINavigationController
    var viewModel: QuotationViewModel
    var childCoordinators: [Coordinator] = []
    weak var currencyList: CurrenciesQuotationDelegate?
    
    init(navigationController: UINavigationController, manager: NetworkManager) {
        self.navigationController = navigationController
        self.viewModel = QuotationViewModel(manager: manager)
    }
    
    func start() {
        let controller = QuotationViewController(viewModel: viewModel)
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func showCurrencyList(){
        let coordinator = CurrencyListCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
        currencyList = (coordinator).delegate
    }
}
