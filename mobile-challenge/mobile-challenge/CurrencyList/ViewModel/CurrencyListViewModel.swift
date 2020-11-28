//
//  CurrencyListViewModel.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 27/11/20.
//

import Foundation

enum TypeSort {
    case code
    case name
}

class CurrencyListViewModel {
    
    init() {
        
    }
    
    func sortArray(by type: TypeSort, currenciesQuotation: [CurrencyQuotation]) -> [CurrencyQuotation] {
        if type == .code {
            let sortedList = currenciesQuotation.sorted { (cQuotarion, cQuotation2) -> Bool in
                return cQuotarion.code < cQuotation2.code
            }
            
            return sortedList
        } else {
            let sortedList = currenciesQuotation.sorted { (cQuotarion, cQuotation2) -> Bool in
                return cQuotarion.currency < cQuotation2.currency
            }
            
            return sortedList
        }
    }
}
