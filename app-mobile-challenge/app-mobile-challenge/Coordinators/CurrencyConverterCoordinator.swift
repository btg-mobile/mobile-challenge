//
//  CurrencyConverterCoodinator.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 27/11/20.
//

import UIKit
import Combine

// Protocols

protocol CurrencyConverterCoordinatorService: Coordinator {
    func showSupporteds(type: PickCurrencyType)
    func back()
}

// Class

final class CurrencyConverterCoordinator: CurrencyConverterCoordinatorService {

    // Properties

    var navigationController: UINavigationController

    // Lifecycle

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        requestData()
    }

    // Router

    private func showInitial() {
        let viewModel = CurrencyConverterViewModel(coordinator: self)
        let viewController = CurrencyConverterViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    func showSupporteds(type: PickCurrencyType) {
        let viewModel = SupportedCurrenciesViewModel(coordinator: self)
        let viewController = SupportedCurrenciesViewController(viewModel: viewModel, type: type)
        navigationController.pushViewController(viewController, animated: true)
    }

    func back() {
        navigationController.popViewController(animated: true)
    }

    // API

    private func requestData() {
        ListCurrency.getFromWeb() {}
        LiveCurrency.getFromWeb() {}
        showInitial()
    }
}
