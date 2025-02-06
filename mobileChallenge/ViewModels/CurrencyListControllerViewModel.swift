//
//  CurrencyListControllerViewModel.swift
//  mobileChallenge
//
//  Created by Henrique on 05/02/25.
//

import Foundation
import UIKit

class CurrencyListControllerViewModel {
    
    
    public func inSearchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        return isActive && !searchText.isEmpty
    }
    
    public func updateSearchController(searchBarText: String?, filteredCurrencies: inout [CurrencyName]) {
        if let searchText = searchBarText?.lowercased(){
            guard !searchText.isEmpty else {
                return
            }
            filteredCurrencies = filteredCurrencies.filter({ $0.code.lowercased().contains(searchText.lowercased()) || $0.name.lowercased().contains(searchText.lowercased())})
        }
    }
}
