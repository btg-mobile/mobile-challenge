//
//  CurrencyListCoordinator.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu (ACT CONSULTORIA EM TECNOLOGIA LTDA – GEDES – MG) on 14/07/22.
//

import Foundation
import UIKit

class CurrencyListCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        childCoordinators = []
        self.navigationController = navigationController
    }

    func start() {}
    
    func start(viewModel: CurrencyListViewModel, isInitial: Bool) {
        let vc = CurrencyListScreenFactory.buildCurrencyListScreen(viewModel: viewModel, isInitial: isInitial)
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didSelectCurrency() {
        navigationController?.popViewController(animated: true)
    }
    
}
