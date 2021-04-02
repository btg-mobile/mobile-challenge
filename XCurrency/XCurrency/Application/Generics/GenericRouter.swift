//
//  GenericRouter.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

import UIKit

class GenericRouter {

    // MARK: - Attributes
    private var navigationController: UINavigationController!
    private var viewController: UIViewController!

    // MARK: - Initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Public Methods
    func present() {
        self.navigationController.pushViewController(self.viewController, animated: true)
    }

    func dismiss() {
        self.navigationController.popViewController(animated: true)
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
}
