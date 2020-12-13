//
//  ExchangeModalTableView.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 12/12/20.
//

import Foundation
import UIKit
extension ExchangeModalViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.supportedListSearch!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = viewModel.supportedListSearch![indexPath.row].currencyName
        cell.detailTextLabel?.text = viewModel.supportedListSearch![indexPath.row].currencyCode
        // Dismiss keyboard on Drag
        tableView.keyboardDismissMode = .onDrag
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = viewModel.supportedListSearch![indexPath.row].currencyCode
        viewModel.addSelectedItem(uiTableView: tableView, selectedItem: selectedItem, selected: selected, delegate: updateLabels)
        self.dismiss(animated: true, completion: nil)
    }

}
