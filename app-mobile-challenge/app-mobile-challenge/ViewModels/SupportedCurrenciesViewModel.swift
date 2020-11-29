//
//  SupportedCurrenciesViewModel.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

final class SupportedCurrenciesViewModel {
    
    /// Descreve o coordinator.
    private let coordinator: CurrencyConverterCoordinatorService
    
    /// Inicializador do ViewModel
    /// - Parameter coordinator: O coordinator controla todas as operações de navegação entre telas.
    init(coordinator: CurrencyConverterCoordinatorService) {
        self.coordinator = coordinator
    }
    
    /// Volta para a tela anterior.
    public func back() {
        ImpactFeedback.run(style: .heavy)
        coordinator.back()
    }
    
    /// Descreve o título principal da tela de moedas suportadas.
    /// - Returns: Título da controller.
    public func title() -> String {
        return "Moedas"
    }
    
    /// Salva a moeda selecionada e volta para a tela inicial.
    /// - Parameters:
    ///   - currency: Moeda selecionada, `Currency`
    ///   - type: Tipo de `PickCurrencyType`
    public func choiced(currency: Currency, type: PickCurrencyType) {
        if type == .none { return }
        ImpactFeedback.run(style: .heavy)
        switch type {
        case .none:
            return
        case .from:
            CommonData.shared.fromCurrencyStorage = currency.code
        case .to:
            CommonData.shared.toCurrencyStorage = currency.code
        }
        back()
    }
}
