//
//  MainCoordinator.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var viewController: ConverterViewController!
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        viewController = ConverterViewController.instantiate()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    
}

extension MainCoordinator: ConverterViewControllerCoordinator {
    func currencyListView(buttonTapped: ButtonTapped) {
        let currencyListVC = CurrencyListViewController.instantiate()
        currencyListVC.converterViewModel = viewController.viewModel
        currencyListVC.buttonTapped = buttonTapped
        navigationController.pushViewController(currencyListVC, animated: true)
    }
    
}
