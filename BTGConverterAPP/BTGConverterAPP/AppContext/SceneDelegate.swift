//
//  SceneDelegate.swift
//  BTGConverterAPP
//
//  Created by Leonardo Maia Pugliese on 15/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabbar()
        window?.makeKeyAndVisible()
        
        configureNavigationBar()
    }
    
    func createSearchVC() -> UIViewController {
        let currencyConverterVC = BTGCurrencyConverterVC()
        currencyConverterVC.title = "BTG Currency Converter"
        currencyConverterVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return currencyConverterVC
    }
    
    func createFavoritesVC() -> UIViewController {
        let currencyListVC = BTGCurrencyListVC()
        currencyListVC.title = "BTG Currency List"
        currencyListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent , tag: 1)
        return currencyListVC
    }
    
    func createTabbar() -> UITabBarController {
        
        let tabbar = UITabBarController()
        UITabBar.appearance().tintColor = .systemGreen
        tabbar.viewControllers = [createSearchVC(),createFavoritesVC()]
        return tabbar
        
    }
    
    func configureNavigationBar() {
          UINavigationBar.appearance().tintColor = .systemGreen
      }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

