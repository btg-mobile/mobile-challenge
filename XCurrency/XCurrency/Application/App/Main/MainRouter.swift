//
//  MainRouter.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

import UIKit

class MainRouter: GenericRouter {
    
    // MARK: - Overrides
    override init(window: UIWindow, navigationController: UINavigationController) {
        let viewModel = MainViewModel()
        super.init(window: window, navigationController: navigationController)
        viewModel.router = self
        let mainViewController = MainViewController(mainViewModel: viewModel)
        self.setViewController(viewController: mainViewController)
    }

    // MARK: - Public Methods
    func presentCurrencysView(order: CurrencyOrder) {
        let currencysRouter = CurrencysRouter(window: self.getWindow(), navigationController: self.getNavigationController())
        currencysRouter.getViewController().title = (order == .first) ? "First Currency" : "Second Currency"
        currencysRouter.present()
    }
}
