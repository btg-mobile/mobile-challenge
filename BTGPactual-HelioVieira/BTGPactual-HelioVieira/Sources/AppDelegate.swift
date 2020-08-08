//
//  AppDelegate.swift
//  BTGPactual-HelioVieira
//
//  Created by Helio Junior on 07/08/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = HomeViewController().instantiate()
        homeViewController.title = "BTG Pactual - Currency Converter"
        let nav = UINavigationController(rootViewController: homeViewController)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        return true
    }

}

