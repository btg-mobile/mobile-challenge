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
        print("TODO")
    }
    
    //TODO
    func pickCurrency(currencies: ListCurrencyResponse) {
        print("TODO")
    }
    
    //TODO
    func chooseCurrency(currencies: ListCurrencyResponse) {
        print("TODO")
    }
}
