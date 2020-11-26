//
//  MainCoordinator.swift
//  convertMoneys
//
//  Created by Mateus Rodrigues Santos on 25/11/20.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let convertVC = ConvertViewController()
        convertVC.coordinator = self
        navigationController.pushViewController(convertVC, animated: true)
    }
}

//MARK: Functions
extension MainCoordinator{
    func navigateToCurrencyViewController(destinyData:CurrencyViewModelDestiny, delegateCurrency:ConvertViewController) {
        
        let currencyVC = CurrencyViewController()
        currencyVC.coordinator = self
        currencyVC.delegateSendData = delegateCurrency
        currencyVC.viewModel.myDestinyData = destinyData
        
        navigationController.present(currencyVC, animated: true, completion: nil)
    }
    

}

