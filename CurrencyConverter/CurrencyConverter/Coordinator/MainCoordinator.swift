//
//  MainCoordinator.swift
//  CurrencyConverter
//
//  Created by Eduardo Lopes on 29/09/21.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = HomeViewModel(coordinator: self)
        let controller = HomeController(viewModel: viewModel, nil, nil)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func openList(origin: Int) {
        let controller = CurrencyListController(origin: origin, delegate: self)
        navigationController.pushViewController(controller, animated: true)
    }
    
}

extension MainCoordinator: CurrencyListDelegate {
    func didSelectedCurrency(_ currency: String, origin: Int) {
        let viewModel = HomeViewModel(coordinator: self)
        let controller = HomeController(viewModel: viewModel, currency, origin)
        navigationController.pushViewController(controller, animated: true)
    }
    
}
