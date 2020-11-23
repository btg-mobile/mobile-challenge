//
//  CurrencyTableViewManager+Delegate.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation
import UIKit

extension CurrencyTableViewManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyListViewModel.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier) as! CurrencyTableViewCell
        
        if sortType == .code {
            cell.currency = currencyListViewModel.currenciesByCode[indexPath.row]
        } else {
            cell.currency = currencyListViewModel.currenciesByName[indexPath.row]
        }
        
        cell.setupViews()
        
        return cell
    }
}
