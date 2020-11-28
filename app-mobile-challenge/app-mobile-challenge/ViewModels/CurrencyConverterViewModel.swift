//
//  CurrencyConverterViewModel.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 27/11/20.
//

import UIKit

protocol CurrencyConverterService: class {
    func updateView()
}

final class CurrencyConverterViewModel {
    @UserDefaultAccess(key: "USD", defaultValue: "USD")
    private var fromCurrencyStorage: String
    
    @UserDefaultAccess(key: "USD", defaultValue: "USD")
    private var toCurrencyStorage: String
    
    private let coordinator: CurrencyConverterCoordinatorService
    private weak var delegate: CurrencyConverterService?
    
    
    public var fromCurrency: String {
        return fromCurrencyStorage
    }
    
    public var toCurrency: String {
        return toCurrencyStorage
    }
    
    /// Valor da moeda atual a ser convertida.
    public var currencyValue: String = ""
    
    /// Inicializador
    /// - Parameter coordinator: O coordinator controla todas as operações de navegação entre telas.
    init(coordinator: CurrencyConverterCoordinatorService) {
        self.coordinator = coordinator
    }
    // Coordinators
    /// Abre a tela de moedas suportadas.
    public func pickSupporteds() {
        coordinator.showSupporteds()
    }
    // End Coordinators
    
    /// Pega a conversão de moedas.
    /// - Returns: Retorna o valor convertido para a moeda selecionada.
    public func calculateConvertion() -> String {
        if (currencyValueIsEmpty()) { return "1,00" }
        return currencyValue
    }
    
    /// Verifica se o valor para a conversão está vazio.
    public func currencyValueIsEmpty() -> Bool {
        return currencyValue == ""
    }
}
