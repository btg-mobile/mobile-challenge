//
//  GenericRouter.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

import UIKit

class GenericRouter {

    // MARK: - Attributes
    private let window: UIWindow
    private var navigationController: UINavigationController!
    private var viewController: UIViewController!

    // MARK: - Initializer
    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }

    // MARK: - Public Methods
    func present() {
        UIView.transition(with: self.window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.navigationController.pushViewController(self.viewController, animated: true)
        }, completion: nil)
    }

    func dismiss() {
        self.viewController?.dismiss(animated: true, completion: nil)
    }

    func getNavigationController() -> UINavigationController {
        return self.navigationController
    }

    func getViewController() -> UIViewController {
        return self.viewController
    }

    func setViewController(viewController: UIViewController) {
        self.viewController = viewController
    }

    func getWindow() -> UIWindow {
        return self.window
    }
}
