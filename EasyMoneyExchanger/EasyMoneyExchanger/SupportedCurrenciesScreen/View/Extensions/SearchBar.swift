//
//  SearchBar.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 12/12/20.
//

import Foundation
import UIKit
extension SupportedCurrenciesViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Filter Dictionary
        print(searchText)

        if searchText.count > 0 {
            viewModel?.isSearching = true
        } else {
            viewModel?.isSearching = false
        }
        tableView.reloadData()
    }

    // Disable keyboard on Press Search Button
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
