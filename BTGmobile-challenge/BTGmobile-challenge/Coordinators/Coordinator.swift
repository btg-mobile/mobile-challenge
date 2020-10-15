//
//  Coordinator.swift
//  BTGmobile-challenge
//
//  Created by Cassia Aparecida Barbosa on 09/10/20.
//

import Foundation
import UIKit

protocol Coordinator {
	
	var navigationController: UINavigationController { get set }
	
	func presentViewController()
}
