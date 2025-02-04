//
//  SearchBarDelegate.swift
//  MobileChallenge
//
//  Created by Gabriel Vicentin Negro on 20/11/24.
//

import Foundation
import UIKit

class SearchBarDelegate: NSObject, UISearchBarDelegate {
    weak var listOfCurrencyViewModel: ListOfCurrencyViewModel?
    
    init(listOfCurrencyViewModel: ListOfCurrencyViewModel? = nil) {
        self.listOfCurrencyViewModel = listOfCurrencyViewModel
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let listOfCurrencyViewModel = listOfCurrencyViewModel else {return}
        if !searchText.isEmpty {
            listOfCurrencyViewModel.filterListOfCurrency(searchText: searchText)
        } else {
            listOfCurrencyViewModel.resetFilterListOfCurrency()
        }
    }
}
