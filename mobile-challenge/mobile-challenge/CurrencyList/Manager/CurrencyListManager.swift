//
//  CurrencyListManager.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 27/11/20.
//

import UIKit

class CurrencyListManager: NSObject {
    var currenciesDict: [[String : [CurrencyQuotation]]] = [[:]]
    var tableView: UITableView?
    var viewModel: CurrencyListViewModel
    
    var selectedCurrency: ((CurrencyQuotation)->())?
    
    override init() {
        self.viewModel = CurrencyListViewModel()
    }
    
}

extension CurrencyListManager: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return currenciesDict.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currenciesDict[section].values.first?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.identifier, for: indexPath) as! CurrencyCell
        cell.setUp()
        
        cell.code.text = currenciesDict[indexPath.section].values.first?[indexPath.row].code
        cell.name.text = currenciesDict[indexPath.section].values.first?[indexPath.row].currency
        let formatedQuotationString = "USD: \(currenciesDict[indexPath.section].values.first?[indexPath.row].quotation ?? 0.0)"
        cell.quotation.text = formatedQuotationString
        
        return cell
    }
}

extension CurrencyListManager: UITableViewDelegate {

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currency = currenciesDict[indexPath.section].values.first?[indexPath.row] else { return }
        selectedCurrency?(currency)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let currenciesDictKey = currenciesDict[section].keys.first {
            
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CurrencyListHeader.identifier) as! CurrencyListHeader
            header.setUpViews()
            header.label.text = currenciesDictKey
            
            return header
        } else {
            return UIView(frame: .zero)
            
        }
    }
}

extension CurrencyListManager: UISearchBarDelegate {
    
}

