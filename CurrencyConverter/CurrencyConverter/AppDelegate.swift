//
//  AppDelegate.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu on 25/09/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = ConversionScreenFactory.buildConversionScreen()
        
        /// remove this after project is finished
//        let viewModel = ViewModel()
//        let repository: Repository = RepositoryDefault()
//        viewModel.repository = repository

        
//        let vc = CurrencyListScreenFactory.buildCurrencyListScreen(viewModel: viewModel, isInitial: true)
        let navController = UINavigationController(rootViewController: vc)
        navController.view.backgroundColor = .white
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }


}

