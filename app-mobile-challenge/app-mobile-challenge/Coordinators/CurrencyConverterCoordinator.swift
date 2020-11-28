//
//  CurrencyConverterCoodinator.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 27/11/20.
//

import UIKit
import os.log

protocol CurrencyConverterCoordinatorService: Coordinator {
    func showSupporteds()
    func back()
}

final class CurrencyConverterCoordinator: CurrencyConverterCoordinatorService {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    /// Inicializa o fluxo de telas
    func start() {
        os_log("Coordinator: showing initial screen.", log: .appflow, type: .debug)
        let viewModel = CurrencyConverterViewModel(coordinator: self)
        let viewController = CurrencyConverterViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showSupporteds() {
        let viewModel = SupportedCurrenciesViewModel(coordinator: self)
        let viewController = SupportedCurrenciesViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
}
