//
//  ListInteractor.swift
//  BTG Converser
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class ListInteractor {

    unowned private let presenter: ListPresenterToInteractor

    init (presenter: ListPresenterToInteractor) {
        self.presenter = presenter
    }

}

// MARK: - ListInteractorToPresenter

extension ListInteractor: ListInteractorToPresenter {

    func fetchCurrencies() {
        let currencies = CurrencyModel.getAll()

        var listItems: [ListItem] = []

        for currency in currencies {
            guard let code = currency.code, let name = currency.name else { continue }
            listItems.append(ListItem(code: code, name: name))
        }

        self.presenter.didFetchCurrencies(listItems)
    }

}
