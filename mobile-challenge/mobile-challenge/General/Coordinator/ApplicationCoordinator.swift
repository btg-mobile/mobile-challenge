//
//  Coordinator.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 25/11/20.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    let window: UIWindow
    let rootViewController: UINavigationController
    let quotationCoordinator: QuotationCoordinator
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        self.quotationCoordinator = QuotationCoordinator(navigationController: rootViewController)
    }
    
    func start() {
        window.rootViewController = rootViewController
        quotationCoordinator.start()
        window.makeKeyAndVisible()
    }
}
