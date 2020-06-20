//
//  MainCoordinator.swift
//  CurrencyConverterBTG
//
//  Created by Silvia Florido on 19/06/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation
import UIKit


protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}



class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ConversionViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func selectCurrency() {
        let vc = CurrencyListViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
}
