//
//  AppCoordinator.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 10/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var parentViewController: UIViewController?
    
    let window: UIWindow
    lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.barTintColor = UIColor.darkBlue
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.isTranslucent = false
        
        if let font = UIFont.btgLabelMedium() {
            navigationController.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: font
            ]
        }
        
        return navigationController
    }()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let provider = HTTPProvider<CurrencyRouter>()
        let repository = CurrencyRepositoryImpl(provider: provider)
        let viewModel = CoinConvertViewModel(repository: repository)
        let viewController = CoinConvertViewController(viewModel: viewModel, coordinator: self)
        viewModel.viewController = viewController
        
        navigationController.pushViewController(viewController, animated: false)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator: CoinConvertCoordinatorDelegate {
    func showCoinList() {
        let provider = HTTPProvider<CurrencyRouter>()
        let repository = CurrencyRepositoryImpl(provider: provider)
        let viewModel = CoinListViewModel(repository: repository)
        let coinListViewController = CoinListViewController(viewModel: viewModel, coordinator: self)
        viewModel.viewController = coinListViewController
        
        navigationController.pushViewController(coinListViewController, animated: true)
    }
}

extension AppCoordinator: CoinListCoordinatorDelegate {
    
}
