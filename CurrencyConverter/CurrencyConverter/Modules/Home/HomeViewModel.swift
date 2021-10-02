//
//  HomeViewModel.swift
//  CurrencyConverter
//
//  Created by Eduardo Lopes on 29/09/21.
//

import Foundation
import UIKit

protocol OriginSelected {
    func onOriginSelected(origin: Origin, title: String)
}

protocol HomeControllerDelegate {
    func originUpdated(origin: Origin, title: String)
}

enum Origin {
    case currency
    case newCurrency
}

class HomeViewModel {
    var coordinator: MainCoordinator?
    var controllerDelegate: HomeControllerDelegate?
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
    
    @objc func didTapCurrency(_ sender: UIButton!) {
        coordinator?.openList(origin: .currency)
    }
    
    @objc func didTapNewCurrency(_ sender: UIButton) {
        coordinator?.openList(origin: .newCurrency)
    }
    
}

extension HomeViewModel: OriginSelected {
    func onOriginSelected(origin: Origin, title: String) {
        controllerDelegate?.originUpdated(origin: origin, title: title)
    }
    
}
