//
//  MainCoordinator.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var viewController: ConverterViewController!
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = ConverterViewModel()
        viewController = ConverterViewController(viewModel: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    
}

extension MainCoordinator: ConverterViewControllerCoordinator {
    func currencyListView(buttonTapped: ButtonTapped) {
        let viewModel = CurrencyListViewModel()
        let vc = CurrencyListViewController(viewModel: viewModel,
                                                        converterViewModel: viewController.viewModel,
                                                        buttonTapped: buttonTapped)
        viewModel.delegate = vc
        navigationController.pushViewController(vc, animated: true)
        
    }
    
}
