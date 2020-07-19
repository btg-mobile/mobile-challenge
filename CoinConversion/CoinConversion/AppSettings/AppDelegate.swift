//
//  AppDelegate.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 18/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .colorDarkishPink
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white,
                                               .font: UIFont.systemFont(ofSize: 25) ]
        
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.prefersLargeTitles = true
        navigationBarAppearance.tintColor = .white
        navigationBarAppearance.standardAppearance = appearance
        navigationBarAppearance.compactAppearance = appearance
        navigationBarAppearance.scrollEdgeAppearance = appearance
        navigationBarAppearance.isTranslucent = false
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
    }
}
