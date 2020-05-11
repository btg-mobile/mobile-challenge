//
//  MainInteractor.swift
//  BTG Converser
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class MainInteractor {

    unowned private let presenter: MainPresenterToInteractor

    init (presenter: MainPresenterToInteractor) {
        self.presenter = presenter
    }

    private let taxsPath = "/live"
    private let currenciesPath = "/list"

    private func getLastUpdateDate() {
        self.presenter.failToFetchDataInAPI(lastUpdate: LocalData.instance.apiLastUpdateDate)
    }

    private func saveTaxReponse(_ response: TaxResponse) {
        
    }

}

// MARK: - MainInteractorToPresenter

extension MainInteractor: MainInteractorToPresenter {

    func fetchTaxsAndCurrenciesInAPI() {
        API.instance.get(path: self.taxsPath) { [weak self] (data, _, error) in
            if let error = error {
                debugPrint(error)
                self?.getLastUpdateDate()
                return
            }

            guard let data = data else {
                self?.getLastUpdateDate()
                return
            }

            do {
                let res = try JSONDecoder().decode(TaxResponse.self, from: data)
                self?.saveTaxReponse(res)
            } catch let error {
                debugPrint(error)
                self?.getLastUpdateDate()
            }
        }
    }
}
