//
//  Coordinator.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 27/11/20.
//

import UIKit

/// Base do `Coordinator`
protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
