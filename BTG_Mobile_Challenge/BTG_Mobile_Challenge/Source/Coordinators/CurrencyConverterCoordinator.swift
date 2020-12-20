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
    
    //TODO
    func start() {
        let viewModel = CurrencyConverterViewModel(requestManager: requestManager, coordinator: self)
        let viewController = CurrencyConverterViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    //TODO
    func pickCurrency(currencies: CurrencyResponseFromList) {
        print("TODO")
    }
    
    //TODO
    func chooseCurrency(currencies: CurrencyResponseFromList) {
        print("TODO")
    }
}
