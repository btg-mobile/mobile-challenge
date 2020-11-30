//
//  SceneDelegate.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 27/11/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    /// Navegation controller já configurada.
    private var defaultNavegation: UINavigationController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.tintColor = .systemRed
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemRed]
        navigationController.setNavigationBarHidden(true, animated: false)
        return navigationController
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navagation = defaultNavegation
        let coordinator = CurrencyConverterCoordinator(navigationController: navagation)
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navagation
        window?.makeKeyAndVisible()
        coordinator.start()
    }

}

