//
//  CurrencyListScreenFactory.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu on 25/09/21.
//

import UIKit

struct CurrencyListScreenFactory {
    static func buildCurrencyListScreen(viewModel: CurrencyListViewModel, isInitial: Bool) -> UIViewController {
        let viewController = CurrencyListViewController()

        viewController.isInitial = isInitial
        viewController.viewModel = viewModel
        viewModel.currencyListDelegate = viewController

        return viewController
    }
}
