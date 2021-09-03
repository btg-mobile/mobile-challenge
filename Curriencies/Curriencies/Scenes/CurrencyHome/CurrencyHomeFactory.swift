//
//  CurrencyHomeFactory.swift
//  Curriencies
//
//  Created by Ferraz on 03/09/21.
//

import UIKit

enum CurrencyHomeFactory {
    static func make() -> UIViewController {
        let localData: LocalCurrencyProtocol = LocalDataCurrency()
        let apiData: APICurrencyProtocol = APICurrency()
        let repository: CurrencyRepositoryProtocol = CurrencyRepository(apiCurrency: apiData,
                                                                        localCurrency: localData)
        
        let useCase: GetCurrencyUseCaseProtocol = GetCurrencyUseCase(repository: repository)
        let viewModel: CurrencyViewModeling = CurrencyViewModel(getCurrenciesUseCase: useCase)
        let viewController = CurrencyHomeViewController(viewModel: viewModel)
        
        return viewController
    }
}
