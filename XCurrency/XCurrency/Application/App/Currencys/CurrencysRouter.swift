//
//  CurrencysRouter.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

import UIKit

class CurrencysRouter: GenericRouter {

    // MARK: - Overrides
    override init(window: UIWindow) {
        super.init(window: window)
        let viewModel = CurrencysViewModel()
        self.setViewController(viewController: CurrencysViewController(currencysViewModel: viewModel))
    }
}
