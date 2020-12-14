//
//  ExchangeModalSearchBar.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 13/12/20.
//

import Foundation
import UIKit
extension ExchangeModalViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.supportedListSearch = viewModel.filterSearchbarList(list: (viewModel.supportedList)!, searchText: searchText )
        tableView.reloadData()
    }

    // Disable keyboard on Press Search Button
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
