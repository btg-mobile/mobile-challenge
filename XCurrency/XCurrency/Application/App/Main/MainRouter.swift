//
//  MainRouter.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

import UIKit

class MainRouter: GenericRouter {
    // MARK: - Overrides
    override init(window: UIWindow) {
        super.init(window: window)
        let viewModel = MainViewModel()
        self.setViewController(viewController: MainViewController(mainViewModel: viewModel))
    }
}
