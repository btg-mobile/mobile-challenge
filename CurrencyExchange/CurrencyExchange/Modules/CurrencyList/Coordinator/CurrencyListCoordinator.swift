//
//  CurrencyListCoordinator.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import UIKit

final class CurrencyListCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var presenter: UINavigationController
    private var currencyListViewController: CurrencyListViewController
    private var currencyListViewModel: CurrencyListViewModel
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.currencyListViewModel = CurrencyListViewModel()
        self.currencyListViewController = CurrencyListViewController(viewModel: currencyListViewModel)
    }
    
    // MARK: - Methods
    
    func start() {
        self.presenter.present(currencyListViewController, animated: true)
    }
    
    
}

