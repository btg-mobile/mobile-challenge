//
//  CurrencyTableViewManager+Delegate.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation
import UIKit

extension CurrencyTableViewManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if sortType == .code {
            didSelectCurrency?(currencyListViewModel.currenciesByCode[indexPath.row])
        } else {
            didSelectCurrency?(currencyListViewModel.currenciesByName[indexPath.row])
        }
    }
}
