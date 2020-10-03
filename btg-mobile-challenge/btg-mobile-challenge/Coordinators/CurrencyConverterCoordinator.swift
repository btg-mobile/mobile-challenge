//
//  CurrencyConverterCoordinator.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 02/10/20.
//

import UIKit

/// The service responsible for managing navigation for picking and converting currencies.
protocol CurrencyConverterCoordinatorService: Coordinator {
    @discardableResult func pickCurrency(_ case: CurrencyPickingCase, currencies: ListCurrencyResponse) -> Bool
    init(navigationController: UINavigationController,
         networkManager: NetworkManager)
}

/// `Coordinator` responsible for managing navigation for picking and converting currencies.
final class CurrencyConverterCoordinator: CurrencyConverterCoordinatorService {

    private let networkManager: NetworkManager

    /// The `UINavigationController` responsible for this `Coordinator`.
    var navigationController: UINavigationController

    /// Initiliazes a new instance of this type.
    /// - Parameter navigationController: The `UINavigationController` responsible for this `Coordinator`.
    init(navigationController: UINavigationController,
         networkManager: NetworkManager) {
        self.navigationController = navigationController
        self.networkManager = networkManager
    }

    /// Starts this screen flow.
    func start() {
        let viewModel = CurrencyConverterViewModel(networkManager: networkManager, coordinator: self)
        let viewController = CurrencyConverterViewController(viewModel: viewModel)

        navigationController.pushViewController(viewController, animated: true)
    }

    /// Navigates to currency picking screen.
    @discardableResult func pickCurrency(_ case: CurrencyPickingCase, currencies: ListCurrencyResponse) -> Bool {
        let viewModel = CurrencyPickerViewModel(currencies: currencies, coordinator: self, case: `case`)
        let viewController = CurrencyPickerViewController(viewModel: viewModel)
        let modalNavigationController = UINavigationController(rootViewController: viewController)

        modalNavigationController.modalPresentationStyle = .fullScreen

        navigationController.present(modalNavigationController, animated: true, completion: nil)
        return true
    }

}
