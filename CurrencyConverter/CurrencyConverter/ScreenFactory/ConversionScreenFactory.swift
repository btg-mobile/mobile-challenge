//
//  ConversionScreenFactory.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu on 25/09/21.
//

import UIKit

struct ConversionScreenFactory {
    static func buildConversionScreen() -> ConversionViewController {
        let repository = RepositoryDefault()
        let viewModel = ConversionViewModel(repository: repository)
        let viewController = ConversionViewController(viewModel: viewModel)
        return viewController
    }
}
