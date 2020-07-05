//
//  HomeWireframe.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation

class HomeWireframe {
 
    func makeScreen() -> HomeController {
        let interactor = HomeInteractor(manager: CurrencyManager())
        let presenter = HomePresenter(route: self, interactor: interactor)
        interactor.output = presenter
        let homeController = HomeController()
        homeController.presenter = presenter
        presenter.output = homeController
        return homeController
    }
}
