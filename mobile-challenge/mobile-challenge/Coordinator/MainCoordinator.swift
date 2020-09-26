//
//  MainCoordinator.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ConverterViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    
}

extension MainCoordinator: ConverterViewControllerCoordinator {
    func currencyListView() {
        let currencyListVC = CurrencyListViewController.instantiate()
        navigationController.pushViewController(currencyListVC, animated: true)
    }
    
}
