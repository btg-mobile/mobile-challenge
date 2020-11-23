//
//  CurrencyTableViewManager.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation

/// Class used to manage CurrencyTableView
class CurrencyTableViewManager: NSObject {
    let currencyListViewModel: CurrencyListViewModel
    var sortType: sortType = .name
    var didSelectCurrency: ((CurrencyModel) -> Void)?
    
    init(currencyListViewModel: CurrencyListViewModel){
        self.currencyListViewModel = currencyListViewModel
    }
    
    /// Method to change the way data is sorted
    func changeOrder() {
        if sortType == .code {
            sortType = .name
        } else {
            sortType
                = .code
        }
    }
}
