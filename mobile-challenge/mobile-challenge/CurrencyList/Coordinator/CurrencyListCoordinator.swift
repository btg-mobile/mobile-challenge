//
//  CurrencyListCoordinator.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 27/11/20.
//

import UIKit

class CurrencyListCoordinator: Coordinator {
    var navigationController: UINavigationController
    var delegate : CurrenciesQuotationDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = CurrencyListViewController()
        controller.coordinator = self
        delegate = controller
        navigationController.pushViewController(controller, animated: true)
    }
}
