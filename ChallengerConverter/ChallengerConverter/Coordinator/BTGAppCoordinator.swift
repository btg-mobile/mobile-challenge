//
//  BTGAppCoordinator.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 21/10/21.
//

import Foundation
import UIKit

protocol BTGAppCoordinatorDelegate: class {
    func showPickerCurrencies()
}

class BTGAppCoordinator: Coordinator {
    
    
    private lazy var navController: UINavigationController = {
        let navController = UINavigationController()
        //navController.setNavigationBarHidden(true, animated: false)
        return navController
    }()
    
    init(window: UIWindow?) {
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
    
    func start() {
        let viewModel = BTGCurrencyConverterViewModel(repository: MockCurrencyRepository())
        viewModel.coordinatorDelegate = self
        let viewController = BTGCurrencyConverterViewController(viewModel: viewModel)
        navController.pushViewController(viewController, animated: false)
    }
}

extension BTGAppCoordinator : BTGAppCoordinatorDelegate {
    func showPickerCurrencies() {
        let viewModel = BTGCurrenciesAvaliableViewModel(repository: NetworkCurrencyRepository(), delegate: self)
        let viewController = BTGCurrenciesAvaliableViewController(viewModel: viewModel)
        navController.pushViewController(viewController, animated: true)
    }
}

extension BTGAppCoordinator : BTGCurrenciesAvaliableViewModelDelegate {
    func didChoiseCurrency(currency: Currency) {
        navController.popViewController(animated: true)
    }
}


