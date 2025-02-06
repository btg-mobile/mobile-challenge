//
//  CurrencyTableViewDelegate.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 05/02/25.
//

import Foundation
import UIKit


class CurrencyTableViewDelegate: NSObject, UITableViewDelegate {
    
    var currencyResponse: CurrencyResponse
    weak var currencyCellDelegate: CurrencyCellDelegate?
    
    init(currencyResponse: CurrencyResponse) {
        self.currencyResponse = currencyResponse
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let keys = Array(self.currencyResponse.currencies.keys)
        let currencyKey = keys[indexPath.row]
        currencyCellDelegate?.didSelectCurrency(currency: currencyKey)

    }
}
