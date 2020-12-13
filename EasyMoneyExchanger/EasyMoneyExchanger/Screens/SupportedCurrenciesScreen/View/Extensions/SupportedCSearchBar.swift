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
        if searchText.count > 0 && !searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            viewModel?.supportedListSearch = viewModel?.supportedList?.filter {$0.currencyName.contains(searchText) || $0.currencyCode.contains(searchText)}
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
