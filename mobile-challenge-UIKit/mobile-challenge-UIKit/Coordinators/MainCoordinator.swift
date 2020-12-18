//
//  MainCoordinator.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 16/12/20.
//

import UIKit

class MainCoordinator: Coordinator, CurrencyChoosing {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = CurrencyConverterViewController(coordinator: self)
        navigationController.pushViewController(vc, animated: false)
    }

    func chooseCurrency(onSelect: @escaping (Currency) -> Void) {
        let vc = CurrencyListViewController(coordinator: self, onSelectCurrency: onSelect)
        navigationController.pushViewController(vc, animated: true)
    }

    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
