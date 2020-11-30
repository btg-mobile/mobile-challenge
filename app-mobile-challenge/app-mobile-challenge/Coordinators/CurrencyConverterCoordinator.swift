//
//  CurrencyConverterCoodinator.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 27/11/20.
//

import UIKit
import os.log
import Combine

/// Serviço responsável pela gerenciamento da navegação.
protocol CurrencyConverterCoordinatorService: Coordinator {
    func showSupporteds(type: PickCurrencyType)
    func back()
}

/// `Coordinator` responsável pelas transições de telas do aplicativo.
final class CurrencyConverterCoordinator: CurrencyConverterCoordinatorService {
    
    /// `UINavigationController` responsável pelo `Coordinator`.
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        getDataFromWeb()
    }
    
    /// Inicializa o fluxo de telas.
    func start() {
        let viewModel = CurrencyConverterViewModel(coordinator: self)
        let viewController = CurrencyConverterViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    /// Mostra a tela de moedas suportadas.
    /// - Parameter type: Descreve se é uma tela de escolha de moeda ou somente visualização.
    func showSupporteds(type: PickCurrencyType) {
        let viewModel = SupportedCurrenciesViewModel(coordinator: self)
        let viewController = SupportedCurrenciesViewController(viewModel: viewModel, type: type)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    /// Volta para a tela anterior.
    func back() {
        navigationController.popViewController(animated: true)
    }
    
    /// Faz a request para a captura dos dados online.
    func getDataFromWeb() {
        DispatchQueue.main.async {
            ListCurrency.getFromWeb()
            LiveCurrency.getFromWeb()
        }
    }
}
