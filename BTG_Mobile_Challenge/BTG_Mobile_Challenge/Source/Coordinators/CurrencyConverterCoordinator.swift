//
//  CurrencyConverterCoordinator.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 19/12/20.
//

import UIKit

final class CurrencyConverterCoordinator: CurrencyConverterService {
    
    private let requestManager: RequestManager
    var navigationController: UINavigationController

    
    init(requestManager: RequestManager, navigationController: UINavigationController) {
        self.requestManager = requestManager
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = CurrencyConverterViewModel(requestManager: requestManager, coordinator: self)
        let viewController = CurrencyConverterViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func changeCurrency(selectedCase: SelectCase, response: CurrencyResponseFromList) {
        let viewModel = CurrencyListViewModel(requestManager: requestManager, coordinator: self, selectedCase: selectedCase, response: response)
        let viewController = CurrencyListViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func changeFinished() {
        navigationController.popViewController(animated: true)
        if let viewController = navigationController.topViewController as? CurrencyConverterViewController {
            viewController.viewModel.delegate?.updateUI()
        }
        
    }
}
