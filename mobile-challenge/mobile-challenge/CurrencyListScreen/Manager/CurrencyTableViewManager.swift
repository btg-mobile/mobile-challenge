//
//  CurrencyTableViewManager.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation
import UIKit

class CurrencyTableViewManager: NSObject {
    let currencyListViewModel: CurrencyListViewModel
    
    init(currencyListViewModel: CurrencyListViewModel){
        self.currencyListViewModel = currencyListViewModel
    }
}
