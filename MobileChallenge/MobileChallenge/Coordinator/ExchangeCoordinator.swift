//
//  ExchangeCoordinator.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 03/11/20.
//

import UIKit

protocol ExchangeViewControllerDelegate: class {
    func goToCurrenciesList()
}

final class ExchangeCoordinator: Coordinator {
    
    var presenter: UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let viewController = ExchangeViewController()
        
        presenter.pushViewController(viewController, animated: true)
    }
}

extension ExchangeCoordinator: ExchangeViewControllerDelegate {
    
    func goToCurrenciesList() {
    
    }
}
