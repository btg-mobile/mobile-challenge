//
//  CalculateCurrencyUseCase.swift
//  Curriencies
//
//  Created by Ferraz on 04/09/21.
//

protocol CalculateCurrencyUseCaseProtocol {
    func calculateCurrency(currencies: [CurrencyEntity],
                           originCode: String,
                           destinationCode: String,
                           originValue: Double) -> Double
}

struct CalculateCurrencyUseCase: CalculateCurrencyUseCaseProtocol {
    func calculateCurrency(currencies: [CurrencyEntity],
                           originCode: String,
                           destinationCode: String,
                           originValue: Double) -> Double {
        let originEntity = currencies.first {
            $0.code == originCode
        }
        let destinationEntity = currencies.first {
            $0.code == destinationCode
        }
        let originValueDollar = originValue / (originEntity?.value ?? 1)
        let destinationValue = originValueDollar * (destinationEntity?.value ?? 1)
        
        return destinationValue
    }
}
