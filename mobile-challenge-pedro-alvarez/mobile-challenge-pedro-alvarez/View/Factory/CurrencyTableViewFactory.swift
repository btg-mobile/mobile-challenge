//
//  CurrencyTableViewFactory.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 24/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

class CurrencyTableViewFactory: TableViewFactoryProtocol {
    
    private(set) var viewModel: CurrencyListViewModelProtocol
    
    init(viewModel: CurrencyListViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func buildSections() -> [TableViewSectionProtocol] {
        return [BaseSection(builders: [])]
    }
    
    
}
