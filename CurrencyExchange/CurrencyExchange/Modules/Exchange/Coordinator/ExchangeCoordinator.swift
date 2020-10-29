//
//  ExchangeCoordinator.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import UIKit

final class ExchangeCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var presenter: UINavigationController
    private var exchangeViewController: ExchangeViewController
    private var exchangeViewModel: ExchangeViewModel
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.exchangeViewModel = ExchangeViewModel()
        self.exchangeViewController = ExchangeViewController(viewModel: exchangeViewModel)
    }
    
    // MARK: - Methods
    
    func start() {
        self.presenter.pushViewController(exchangeViewController, animated: true)
    }
    
    
}
