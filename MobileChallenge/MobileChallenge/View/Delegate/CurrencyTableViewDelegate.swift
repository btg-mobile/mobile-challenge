//
//  CurrencyTableViewDelegate.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 05/02/25.
//

import Foundation
import UIKit


class CurrencyTableViewDelegate: NSObject, UITableViewDelegate {
    
    var currencyResponse: [(String, String)]
    weak var currencyCellDelegate: CurrencyCellDelegate?
    
    init(currencyResponse: [(String, String)]) {
        self.currencyResponse = currencyResponse
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCurrency = currencyResponse[indexPath.row]
        currencyCellDelegate?.didSelectCurrency(currency: selectedCurrency.0)

    }
}
