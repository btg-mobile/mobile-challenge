//
//  CurrencyConverterViewModel.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 27/11/20.
//

import UIKit
import Combine

protocol CurrencyConverterService: class {
    func updateView()
}

final class CurrencyConverterViewModel {
    
    private let coordinator: CurrencyConverterCoordinatorService
    private weak var delegate: CurrencyConverterService?
    
    
    public var fromCurrency: String {
        return CommonData.shared.fromCurrencyStorage
    }
    
    public var toCurrency: String {
        return CommonData.shared.toCurrencyStorage
    }
    
    /// Valor da moeda atual a ser convertida.
    public var currencyValue: String = ""

    
    /// Inicializador
    /// - Parameter coordinator: O coordinator controla todas as operações de navegação entre telas.
    init(coordinator: CurrencyConverterCoordinatorService) {
        self.coordinator = coordinator
    }
    // Coordinators
    /// Salva o dado de transição de tela e abre a tela de moedas suportadas.
    public func pickSupporteds(type: PickCurrencyType) {
        ImpactFeedback.run(style: .medium)
        CommonData.shared.selectedTypeCurrency = type.rawValue
        coordinator.showSupporteds(type: type)
    }
    public func openSupporteds() {
        ImpactFeedback.run(style: .medium)
        CommonData.shared.selectedTypeCurrency = "none"
        coordinator.showSupporteds(type: .none)
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
