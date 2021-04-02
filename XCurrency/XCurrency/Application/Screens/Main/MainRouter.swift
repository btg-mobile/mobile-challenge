//
//  MainRouter.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

import UIKit

class MainRouter: GenericRouter {
    
    // MARK: - Overrides
    override init(navigationController: UINavigationController) {
        let viewModel = MainViewModel(currencyRepository: CurrencyRepository(network: Network()))
        super.init(navigationController: navigationController)
        viewModel.router = self
        let mainViewController = MainViewController(mainViewModel: viewModel)
        self.setViewController(viewController: mainViewController)
    }

    // MARK: - Public Methods
    func presentCurrencysView(order: CurrenciesPosition, selectedCurrency: @escaping (Currency) -> Void) {
        let currencysRouter = CurrencysRouter(navigationController: self.getNavigationController())
        currencysRouter.getViewController().title = (order == .first) ? StringsDictionary.firstCurrency : StringsDictionary.secondCurrency
        (currencysRouter.getViewController() as! CurrencysViewController).setDelegate(selectedCurrency: selectedCurrency)
        currencysRouter.present()
    }
}
