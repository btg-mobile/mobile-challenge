//
//  SceneDelegate.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 24/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.makeKeyAndVisible()
            self.window = window
            let vc = UIViewController()
            vc.view.backgroundColor = .blue
            vc.title = "Title"
            window.rootViewController = UINavigationController(rootViewController: vc)
            
            APIProvider().fetch(withEndpoint: .list) { result in
                print(result)
            }
        }
    }
}

