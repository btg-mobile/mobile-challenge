//
//  ConversionRouter.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 18/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Main
class ConversionRouter {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func createConversionScreen() {
        let viewController = ConversionViewController(
            viewModel: ConversionViewModel(
                service: CurrenciesConversionService(),
                router: self
        ))
        
        let navigationController = UINavigationController(
            rootViewController: viewController
        )
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func enqueueListCurrencies(_ conversion: Conversion) {
        let viewController = ListCurrenciesViewController(
            viewModel: ListCurrenciesViewModel(
                service: ListCurrenciesService(),
                conversion: conversion
        ))
        
        if let topViewController = UIApplication.shared.topMostViewController() {
            topViewController.navigationController?.pushViewController(
                viewController, animated: true
          )
        }
    }
}