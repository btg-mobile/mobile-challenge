//
//  Coordinator.swift
//  convertMoneys
//
//  Created by Mateus Rodrigues Santos on 25/11/20.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    ///This method active the coordinator
    func start()
}

