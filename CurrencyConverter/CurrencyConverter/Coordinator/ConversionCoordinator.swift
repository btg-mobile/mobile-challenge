//
//  ConversionCoordinator.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu (ACT CONSULTORIA EM TECNOLOGIA LTDA – GEDES – MG) on 14/07/22.
//

import Foundation
import UIKit

class ConversionCoordinator: Coordinator {
    
    weak var parentCoordinator: AppCoordinator?
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        childCoordinators = []
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ConversionScreenFactory.buildConversionScreen()
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapInitialCurrency(viewModel: CurrencyListViewModel, isInitial: Bool) {
        parentCoordinator?.goToCurrencyListScreen(viewModel: viewModel, isInitial: isInitial)
    }
    
    func didTapFinalCurrency(viewModel: CurrencyListViewModel, isInitial: Bool) {
        parentCoordinator?.goToCurrencyListScreen(viewModel: viewModel, isInitial: isInitial)
    }
    
}
