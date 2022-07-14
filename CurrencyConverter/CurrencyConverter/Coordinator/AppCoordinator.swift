//
//  MainCoordinator.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu (ACT CONSULTORIA EM TECNOLOGIA LTDA – GEDES – MG) on 14/07/22.
//

import Foundation
import UIKit

class AppCoordinator: NSObject, Coordinator {
    
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController?
    private var window: UIWindow
    
    init(window: UIWindow, navigationController: UINavigationController? = UINavigationController()) {
        self.window = window
        self.navigationController = navigationController
        self.childCoordinators = []
    }
    
    func start() {
        navigationController?.delegate = self
        goToConversionScreen()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func goToConversionScreen() {
        let child = ConversionCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func goToCurrencyListScreen(viewModel: CurrencyListViewModel, isInitial: Bool) {
        let child = CurrencyListCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.start(viewModel: viewModel, isInitial: isInitial)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in
                childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }

}

extension AppCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        
        if navigationController.viewControllers.contains(fromViewController) { return }
        
        if let conversionViewController = fromViewController as? ConversionViewController {
            childDidFinish(conversionViewController.coordinator)
        }
        
        if let currencyListViewController = fromViewController as? CurrencyListViewController {
            childDidFinish(currencyListViewController.coordinator)
        }

    }
}
