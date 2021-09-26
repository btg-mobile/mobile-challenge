//
//  ConversionScreenFactory.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu on 25/09/21.
//

import UIKit

struct ConversionScreenFactory {
    static func buildConversionScreen() -> UIViewController {
        let viewModel = ViewModel()
        let repository: Repository = RepositoryDefault()
        
        let viewController = ConversionViewController()
        
        viewController.viewModel = viewModel
        viewModel.conversionDelegate = viewController
        viewModel.repository = repository
        
        return viewController
    }
}
