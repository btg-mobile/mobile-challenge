//
//  HomeWireframe.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import UIKit

class HomeWireframe {
    weak var viewController: HomeController?
    
    func makeScreen() -> HomeController {
        let interactor = HomeInteractor(manager: CurrencyManager())
        let presenter = HomePresenter(route: self, interactor: interactor)
        interactor.output = presenter
        let homeController = HomeController()
        homeController.presenter = presenter
        presenter.output = homeController
        viewController = homeController
        return homeController
    }
    
    func showList(removeSymbol: String) {
        let listView = ListCurrencyWireframe().makeScreen(removeSymbol: removeSymbol)
        let navigation = UINavigationController(rootViewController: listView)
        navigation.modalPresentationStyle = .fullScreen
        viewController?.present(navigation, animated: true, completion: nil)
    }
}
