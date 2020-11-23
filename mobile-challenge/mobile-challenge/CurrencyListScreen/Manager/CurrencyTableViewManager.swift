//
//  CurrencyTableViewManager.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation

class CurrencyTableViewManager: NSObject {
    let currencyListViewModel: CurrencyListViewModel
    var sortType: sortType = .name
    
    init(currencyListViewModel: CurrencyListViewModel){
        self.currencyListViewModel = currencyListViewModel
    }
    
    func changeOrder() {
        if sortType == .code {
            sortType = .name
        } else {
            sortType
                = .code
        }
    }
}
