//
//  CurrencyListCoordinator.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 14/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit
import Moya

class CurrencyListCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigation: UINavigationController
    let viewController: CurrencyListViewController
    let targertViewController: UIViewController
    
    init(navigation: UINavigationController, targertViewController: UIViewController) {
        let provider = MoyaProvider<CurrencyListRoute>()
        let service = CurrencyListService(provider: provider)
        let viewModel = CurrencyListViewModel(service: service)
        self.viewController = CurrencyListViewController(with: viewModel)
        self.navigation = navigation
        self.targertViewController = targertViewController
    }
    
    func start(with presentation: Presentation) -> UIViewController {
        self.start(presentation: presentation)
        return self.viewController
    }
    
    private func start(presentation: Presentation) {
        switch presentation {
        case .present(animated: let animated):
            self.navigation.present(viewController, animated: animated, completion: nil)
        case .push(animated: let animated):
            self.navigation.pushViewController(viewController, animated: animated)
        case .sheetView(animated: let animated):
            let sheetController = SheetViewController(controller: viewController, sizes: [.fullScreen])
            sheetController.adjustForBottomSafeArea = false
            sheetController.blurBottomSafeArea = true
            sheetController.dismissOnBackgroundTap = true
            sheetController.extendBackgroundBehindHandle = false
            sheetController.topCornersRadius = 15
            targertViewController.present(sheetController, animated: animated, completion: nil)
        }
    }
}
