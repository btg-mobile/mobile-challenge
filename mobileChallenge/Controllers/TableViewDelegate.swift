//
//  TableViewDelegate.swift
//  mobileChallenge
//
//  Created by Henrique on 05/02/25.
//

import Foundation
import UIKit

class TableViewDelegate: NSObject, UITableViewDelegate{
    
    var onSelectedCurrency: ((CurrencyConversionName) -> Void)?
    
    var currencies: [CurrencyName]
    var currencyConversion: [CurrencyConversionName]
    var selectedCurrency: CurrencyName!
    
    init(currencies: [CurrencyName], currencyConversion: [CurrencyConversionName]) {
        self.currencies = currencies
        self.currencyConversion = currencyConversion
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedCurrency = currencies[indexPath.row]
        let currencyConverted = currencyConversion.filter { $0.code.lowercased().contains(selectedCurrency.code.lowercased()) }
        onSelectedCurrency?(currencyConverted.first!)
    }
}
