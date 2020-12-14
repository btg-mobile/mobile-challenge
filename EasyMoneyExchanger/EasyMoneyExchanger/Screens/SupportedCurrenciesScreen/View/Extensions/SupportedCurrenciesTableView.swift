//
//  TableView.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 11/12/20.
//

import Foundation
import UIKit
extension SupportedCurrenciesViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        if viewModel?.isSearching == true {
            return 1
        } else {
            return (viewModel?.supportedTitles.count)!
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if viewModel?.isSearching == true {
            return (viewModel?.supportedListSearch!.count)!
        } else {
            let listKey = viewModel?.supportedTitles[section]
            if let listValues = viewModel?.supportedListDictionary![listKey!] {
                return listValues.count
            } else {
                return 0
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)

        if viewModel?.isSearching == true {
            cell.detailTextLabel?.text = viewModel?.supportedListSearch![indexPath.row].currencyCode
            cell.textLabel?.text = viewModel?.supportedListSearch![indexPath.row].currencyName
        } else {
            let itemKey = viewModel?.supportedTitles[indexPath.section]

            if let keyValues = viewModel?.supportedListDictionary![itemKey!] {
                cell.detailTextLabel?.text = keyValues[indexPath.row].currencyCode
                cell.textLabel?.text = keyValues[indexPath.row].currencyName
            }

            // Dismiss keyboard on Drag
            tableView.keyboardDismissMode = .onDrag
        }

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if viewModel?.isSearching == true {
            return nil
        } else {
            return viewModel?.supportedTitles[section]
        }
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {

        if viewModel?.isSearching == true {
            return nil
        } else {
            return viewModel?.supportedTitles
        }
    }
}
