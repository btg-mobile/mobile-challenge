//
//  CurrencyConverterCoordinator.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 02/10/20.
//

import UIKit

/// `Coordinator` responsible for managing navigation for picking and converting currencies.
final class CurrencyConverterCoordinator: Coordinator {
    /// The `UINavigationController` responsible for this `Coordinator`.
    var navigationController: UINavigationController

    /// Initiliazes a new instance of this type.
    /// - Parameter navigationController: The `UINavigationController` responsible for this `Coordinator`.
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    /// Starts this screen flow.
    func start() {
        let networkManager = NetworkManager()
        let viewModel = CurrencyConverterViewModel(networkManager: networkManager, coordinator: self)
        let viewController = CurrencyConverterViewController(viewModel: viewModel)

        navigationController.pushViewController(viewController, animated: true)
    }

    /// Navigates to currency picking screen.
    func pickCurrency(_ case: CurrencyPickingCase) {
        let viewModel = CurrencyPickerViewModel(coordinator: self, case: `case`)
        let viewController = CurrencyPickerViewController(viewModel: viewModel)
        let modalNavigationController = UINavigationController(rootViewController: viewController)

        navigationController.present(modalNavigationController, animated: true, completion: nil)
    }

}
