//
//  CurrencyConverterViewModel.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 27/11/20.
//

import UIKit
import Combine

/// `ViewModel` responsável pela `CurrencyConverterViewController`.
final class CurrencyConverterViewModel {
    
    /// `Coordinator` associado com esse `ViewModel`.
    private let coordinator: CurrencyConverterCoordinatorService
    
    /// Recupera a informação de moeda selecionada para a conversão do `CommonData`.
    public var fromCurrency: String {
        return CommonData.shared.fromCurrencyStorage
    }
    /// Recupera a informação de moeda selecionada à ser convertida do `CommonData`.
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
    /// Salva o dado de transição de tela e abre a tela de moedas suportadas.
    public func pickSupporteds(type: PickCurrencyType) {
        ImpactFeedback.run(style: .medium)
        CommonData.shared.selectedTypeCurrency = type.rawValue
        coordinator.showSupporteds(type: type)
    }
    /// Abre a tela de Moedas
    public func openSupporteds() {
        ImpactFeedback.run(style: .medium)
        CommonData.shared.selectedTypeCurrency = "none"
        coordinator.showSupporteds(type: .none)
    }
    // End Coordinators
    
    /// Pega a conversão de moedas.
    /// - Returns: Retorna o valor convertido para a moeda selecionada.
    public func calculateConvertion() -> ((valueFrom: String,
                                           valueTo: String)?,
                                           String?) {
        ImpactFeedback.run(style: .heavy)
        return Convertion.getCurrrency(from: fromCurrency,
                                       to: toCurrency,
                                       valueFrom: currencyValue)
    }
    
    /// Verifica se o valor para a conversão está vazio.
    public func currencyValueIsEmpty() -> Bool {
        return currencyValue == ""
    }
}
