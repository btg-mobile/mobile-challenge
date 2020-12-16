//
//  Coordinator.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 16/12/20.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
