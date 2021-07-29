//
//  MainCoordinator.swift
//  Coin Converter
//
//  Created by Igor Custodio on 29/07/21.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = HomeViewModel(service: Service())
        let vc = HomeViewController(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func chooseCurrency(currencyList: [Currency], button: Int, delegate: ChooseCurrencyDelegate) {
        let viewModel = ChooseCurrencyViewModel(currencies: currencyList)
        let vc = ChooseCurrencyViewController(viewModel: viewModel, button: button, delegate: delegate)
        navigationController.pushViewController(vc, animated: true)
    }
}
