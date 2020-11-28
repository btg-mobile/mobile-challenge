//
//  CurrencyConverterCoodinator.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 27/11/20.
//

import UIKit
import os.log

protocol CurrencyConverterCoodinatorService: Coordinator {
}

final class CurrencyConverterCoordinator: CurrencyConverterCoodinatorService {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        os_log("Coordinator: showing initial screen.", log: .appflow, type: .debug)
        let viewController = UIViewController()
        navigationController.pushViewController(viewController, animated: true)

    }
}
