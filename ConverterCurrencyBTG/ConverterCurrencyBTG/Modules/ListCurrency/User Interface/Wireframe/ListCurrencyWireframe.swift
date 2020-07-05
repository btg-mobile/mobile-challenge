//
//  ListCurrencyWireframe.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation


class ListCurrencyWireframe {
    
    func makeScreen(removeSymbol: String) -> ListViewCurrency {
        let interactor = ListCurrencyInteractor(manager: CurrencyManager())
        let presenter = ListCurrencyPresenter(interactor: interactor, wireframe: self, removeSymbol: removeSymbol)
        interactor.output = presenter
        let viewController = ListViewCurrency()
        viewController.presenter = presenter
        presenter.ouput = viewController
        return viewController
    }
}
