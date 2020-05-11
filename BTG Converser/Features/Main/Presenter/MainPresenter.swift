//
//  MainPresenter.swift
//  BTG Converser
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class MainPresenter {

    unowned private let view: MainViewToPresenter

    private lazy var interactor: MainInteractorToPresenter = {
        return MainInteractor(presenter: self)
    }()

    init (view: MainViewToPresenter) {
        self.view = view
    }

}

// MARK: - MainPresenterToView

extension MainPresenter: MainPresenterToView {

    func viewDidLoad() {
        self.interactor.fetchTaxsAndCurrenciesInAPI()
    }

    func updateDataTapped() {
        self.interactor.fetchTaxsAndCurrenciesInAPI()
    }

}

// MARK: - MainPresenterToInteractor

extension MainPresenter: MainPresenterToInteractor {

    func failToFetchDataInAPI(lastUpdate: Date?) {
        if let lastUpdate = lastUpdate {
            self.view.showWarningFailToUpdate(with: lastUpdate.parseToString())
        } else {
            self.view.showErrorFailToUpdate()
        }
    }

}
