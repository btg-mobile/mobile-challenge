//
//  CurrencyViewModel.swift
//  Curriencies
//
//  Created by Ferraz on 02/09/21.
//

import Foundation

protocol CurrencyViewModeling {
    func getCurrencies(finishLoad: @escaping () -> Void)
    func goToCurrencyList(currencyType: CurrencyType)
}

final class CurrencyViewModel {
    let getCurrenciesUseCase: GetCurrencyUseCaseProtocol
    
    init(getCurrenciesUseCase: GetCurrencyUseCaseProtocol) {
        self.getCurrenciesUseCase = getCurrenciesUseCase
    }
}

extension CurrencyViewModel: CurrencyViewModeling {
    func getCurrencies(finishLoad: @escaping () -> Void) {
        getCurrenciesUseCase.getCurrencies { result in
            print(result)
        }
    }
    
    func goToCurrencyList(currencyType: CurrencyType) {
        
    }
}
