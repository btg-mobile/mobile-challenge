//
//  Coordinator.swift
//  Coin Converter
//
//  Created by Igor Custodio on 29/07/21.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
