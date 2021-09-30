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
        let viewModel = CurrencyListViewModel()
        let controller = CurrencyListController(viewModel: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
    
}
