//
//  CurrencyCoordinator.swift
//  BTGmobile-challenge
//
//  Created by Cassia Aparecida Barbosa on 09/10/20.
//

import Foundation
import UIKit

final class CurrencyCoordinator: Coordinator {
	
	var navigationController: UINavigationController
	

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func presentViewController() {
		let viewModel = InitialViewModel(coordinator: self)
		let viewController = InitialViewController(viewModel: viewModel)
		navigationController.pushViewController(viewController, animated: true)
	}
	
	func presentCurrencyViewController(buttonType: String) {
		let viewModel = CurrencyViewModel(buttonType: buttonType)
		let viewController = CurrencyViewController(viewModel: viewModel)
		self.navigationController.pushViewController(viewController, animated: true)
	}
	
}
