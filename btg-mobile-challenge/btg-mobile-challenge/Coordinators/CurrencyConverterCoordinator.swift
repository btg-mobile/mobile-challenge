//
//  CurrencyConverterCoordinator.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 02/10/20.
//

import UIKit

final class CurrencyConverterCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let networkManager = NetworkManager()
        let viewModel = CurrencyConverterViewModel(networkManager: networkManager, coordinator: self)
        let viewController = CurrencyConverterViewController(viewModel: viewModel)

        navigationController.pushViewController(viewController, animated: true)
    }

    func pickCurrency(_ case: CurrencyPickingCase) {
        let viewModel = CurrencyPickerViewModel(coordinator: self, case: `case`)
        let viewController = CurrencyPickerViewController(viewModel: viewModel)
        let modalNavigationController = UINavigationController(rootViewController: viewController)

        navigationController.present(modalNavigationController, animated: true, completion: nil)
    }

}
