//
//  ExchangeCoordinator.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import UIKit

final class ExchangeCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var presenter: UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    // MARK: - Methods
    
    func start() {
        let controller = ExchangeViewController()
        
        self.presenter.pushViewController(controller, animated: true)
    }
    
    
}
