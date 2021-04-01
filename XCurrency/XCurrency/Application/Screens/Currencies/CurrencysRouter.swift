//
//  CurrencysRouter.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

import UIKit

class CurrencysRouter: GenericRouter {

    // MARK: - Overrides
    override init(window: UIWindow, navigationController: UINavigationController) {
        super.init(window: window, navigationController: navigationController)
        let viewModel = CurrencysViewModel(currencyRepository: CurrencyRepository(network: Network()))
        viewModel.router = self
        self.setViewController(viewController: CurrencysViewController(currencysViewModel: viewModel))
    }
}
