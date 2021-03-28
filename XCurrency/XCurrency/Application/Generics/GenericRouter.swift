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
    private var viewController: UIViewController!
    private var presentingViewController: UIViewController!

    // MARK: - Initializer
    init(window: UIWindow) {
        self.window = window
    }

    // MARK: - Public Methods
    func present() {
        UIView.transition(with: self.window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.window.rootViewController = self.viewController
        }, completion: nil)
    }

    func presentFromViewController(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
        self.viewController.modalPresentationStyle = .fullScreen
        self.presentingViewController.present(self.viewController, animated: true, completion: nil)
    }

    func dismiss() {
        self.viewController?.dismiss(animated: true, completion: nil)
    }

    func getViewController() -> UIViewController {
        return self.viewController
    }

    func setViewController(viewController: UIViewController) {
        self.viewController = viewController
    }
}
