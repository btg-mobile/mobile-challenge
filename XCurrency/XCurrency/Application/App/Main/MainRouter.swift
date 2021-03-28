//
//  MainRouter.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

import UIKit

class MainRouter: GenericRouter {

    // MARK: - Attributes
    private var currencysRouter: CurrencysRouter
    
    // MARK: - Overrides
    override init(window: UIWindow) {
        let viewModel = MainViewModel()
        self.currencysRouter = CurrencysRouter(window: window)
        super.init(window: window)
        viewModel.router = self
        let mainViewController = MainViewController(mainViewModel: viewModel)
        self.setViewController(viewController: mainViewController)
    }

    // MARK: - Public Methods
    func presentCurrencysView(order: CurrencyOrder) {
        self.currencysRouter.presentFromViewController(presentingViewController: self.getViewController())
    }
}

enum CurrencyOrder {
    case first
    case second
}
