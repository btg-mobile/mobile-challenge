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
        coordinator.back()
    }
    
    /// Descreve o título principal da tela de moedas suportadas.
    /// - Returns: Título da controller.
    public func title() -> String {
        return "Moedas"
    }
}
