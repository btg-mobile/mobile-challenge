//
//  CurrencyListManager.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 27/11/20.
//

import UIKit

class CurrencyListManager: NSObject {
    var currenciesQuotation: [CurrencyQuotation] = []
    var tableView: UITableView?
    
    var selectedCurrency: ((CurrencyQuotation)->())?
    
}

extension CurrencyListManager: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currenciesQuotation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.identifier, for: indexPath) as! CurrencyCell
        cell.setUp()
        
        cell.code.text = currenciesQuotation[indexPath.row].code
        cell.name.text = currenciesQuotation[indexPath.row].currency
        let formatedQuotationString = "USD: \(currenciesQuotation[indexPath.row].quotation)"
        cell.quotation.text = formatedQuotationString
        return cell
    }
}

extension CurrencyListManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCurrency?(currenciesQuotation[indexPath.row])
    }
}

extension CurrencyListManager: UISearchBarDelegate {
    
}

