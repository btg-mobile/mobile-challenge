//
//  SceneDelegate.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 01/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let navigationVC = UINavigationController()
        window?.rootViewController = navigationVC
        navigationVC.pushViewController(HomeViewController(), animated: false)
        window?.makeKeyAndVisible()
    }
}
