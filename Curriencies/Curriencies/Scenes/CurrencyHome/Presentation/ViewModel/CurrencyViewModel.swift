//
//  CurrencyViewModel.swift
//  Curriencies
//
//  Created by Ferraz on 02/09/21.
//

import Foundation

protocol CurrencyViewModeling {
    func getCurrencies(success: @escaping (Bool, String) -> Void)
    func goToCurrencyList(currencyType: CurrencyType)
    func getValue(originValue: Double) -> String
    func updateCurrency(code: String, type: CurrencyType)
}

final class CurrencyViewModel {
    let getCurrenciesUseCase: GetCurrencyUseCaseProtocol
    let calculateUseCase: CalculateCurrencyUseCaseProtocol
    var currencies: [CurrencyEntity] = []
    var originCode: String = "USD"
    var destinationCode: String = "BRL"
    
    init(getCurrenciesUseCase: GetCurrencyUseCaseProtocol,
         calculateCurrencyUseCase: CalculateCurrencyUseCaseProtocol) {
        self.getCurrenciesUseCase = getCurrenciesUseCase
        self.calculateUseCase = calculateCurrencyUseCase
    }
}

extension CurrencyViewModel: CurrencyViewModeling {
    func getCurrencies(success: @escaping (Bool, String) -> Void) {
        getCurrenciesUseCase.getCurrencies { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(entities):
                self.currencies = entities
                let value = self.getValue(originValue: 1)
                success(true, value)
            case .failure(_):
                success(false, "1.00")
            }
        }
    }
    
    func getValue(originValue: Double) -> String {
        let value = calculateUseCase.calculateCurrency(currencies: currencies,
                                                       originCode: originCode,
                                                       destinationCode: destinationCode,
                                                       originValue: originValue)
        
        return String(format: "%.2f", value)
    }
    
    func goToCurrencyList(currencyType: CurrencyType) {
        
    }
    
    func updateCurrency(code: String, type: CurrencyType) {
        if type == .destination {
            originCode = code
        } else {
            destinationCode = code
        }
    }
}
