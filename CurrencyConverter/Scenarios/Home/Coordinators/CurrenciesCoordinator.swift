//
//  CurrenciesCoordinator.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 11/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Foundation
import Swinject
import UIKit

protocol CurrenciesCoordinatorDelegate: AnyObject {
    func currenciesCoordinatorDidFinish()
}

final class CurrenciesCoordinator: NavigationCoordinator {
    
    // MARK: - Properties

    let navigationController: UINavigationController
    let container: Container
    weak var delegate: CurrenciesCoordinatorDelegate?

    init(container: Container, navigationController: UINavigationController) {
        self.container = container
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator core

    func start() {
        showCurrencies()
    }
    
    private func showCurrencies() {
        let vc = container.resolve(CurrenciesViewController.self)!
        vc.delegate = self
        navigationController.pushViewController(vc, animated: true)
    }
}

extension CurrenciesCoordinator: CurrenciesViewControllerDelegate {
}
