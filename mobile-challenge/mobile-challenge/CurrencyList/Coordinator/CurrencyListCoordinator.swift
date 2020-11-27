//
//  CurrencyListCoordinator.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 27/11/20.
//

import UIKit

class CurrencyListCoordinator: Coordinator {
    var navigationController: UINavigationController
    weak var viewController : CurrencyListDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = CurrencyListViewController()
        controller.coordinator = self
        viewController = controller
        navigationController.pushViewController(controller, animated: true)
    }
}

extension CurrencyListCoordinator: CurrenciesQuotationDelegate {
    func didFinishFetchQuotations(currenciesQuotation: [CurrencyQuotation]) {
        viewController?.showCurrencyList(currenciesQuotation: currenciesQuotation)
    }
    
    func didFinishFetchQuotationsWithError(error: Error) {
        viewController?.showError(error: error)
    }
    
    
}
