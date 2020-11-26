//
//  QuotationCoordinator.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 25/11/20.
//

import UIKit

class QuotationCoordinator: Coordinator {
    var navigationController: UINavigationController
    var viewModel: QuotationViewModel
    
    init(navigationController: UINavigationController, manager: NetworkManager) {
        self.navigationController = navigationController
        self.viewModel = QuotationViewModel(manager: manager)
    }
    
    func start() {
        let controller = QuotationViewController(viewModel: viewModel)
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
}
