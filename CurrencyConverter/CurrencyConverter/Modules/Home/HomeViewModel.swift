//
//  HomeViewModel.swift
//  CurrencyConverter
//
//  Created by Eduardo Lopes on 29/09/21.
//

import Foundation
import UIKit

class HomeViewModel {
    var coordinator: MainCoordinator?
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
    
    @objc func didTapCurrency(_ sender: UIButton!) {
        coordinator?.openList(origin: sender.tag)
//        print("teste")
    }
    
    @objc func didTapNewCurrency(_ sender: UIButton) {
        coordinator?.openList(origin: sender.tag)
    }
    
}
