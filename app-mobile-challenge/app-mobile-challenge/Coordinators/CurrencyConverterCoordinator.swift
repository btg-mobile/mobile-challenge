//
//  CurrencyConverterCoodinator.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 27/11/20.
//

import UIKit
import os.log
import Combine

protocol CurrencyConverterCoordinatorService: Coordinator {
    func showSupporteds(type: PickCurrencyType)
    func back()
}

final class CurrencyConverterCoordinator: CurrencyConverterCoordinatorService {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
//        getDataFromWeb()
    }
    
    /// Inicializa o fluxo de telas
    func start() {
        os_log("Coordinator: showing initial screen.", log: .appflow, type: .debug)
        let viewModel = CurrencyConverterViewModel(coordinator: self)
        let viewController = CurrencyConverterViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showSupporteds(type: PickCurrencyType) {
        let viewModel = SupportedCurrenciesViewModel(coordinator: self)
        let viewController = SupportedCurrenciesViewController(viewModel: viewModel, type: type)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
    
    func getDataFromWeb() {
        DispatchQueue.main.async {
            ListCurrency.getFromWeb()
            LiveCurrency.getFromWeb()
        }
    }
}
