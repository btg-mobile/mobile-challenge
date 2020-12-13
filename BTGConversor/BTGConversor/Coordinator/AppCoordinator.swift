//
//  AppCoordinator.swift
//  BTGConversor
//
//  Created by Franclin Cabral on 12/13/20.
//  Copyright © 2020 franclin. All rights reserved.
//

import UIKit

final class AppCoordinator {
    
    let window: UIWindow
    var view: BTGConversorViewController?
    
    required init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewModel = BTGConversorViewModel()
        view = BTGConversorViewController(viewModel)
        window.rootViewController = view
        window.makeKeyAndVisible()
    }
    
    func stop() {
        view = nil
    }
    
}
