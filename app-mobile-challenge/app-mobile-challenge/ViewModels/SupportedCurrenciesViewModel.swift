//
//  SupportedCurrenciesViewModel.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

final class SupportedCurrenciesViewModel {
    
    private let coordinator: CurrencyConverterCoordinatorService
    
    init(coordinator: CurrencyConverterCoordinatorService) {
        self.coordinator = coordinator
    }

    func back() {
        coordinator.back()
    }
}
