//
//  QuotationCoordinator.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 25/11/20.
//

import UIKit

class QuotationCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = QuotationViewController(nibName: nil, bundle: nil)
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
}
