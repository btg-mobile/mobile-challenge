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
    
    private var viewModel: CurrencyListViewModel
    private var currencyList: [CurrencyQuotation] = []
    var state: CurrencyListState
    
    var selectedCurrency: ((CurrencyQuotation)->())?
    
    init(viewModel: CurrencyListViewModel) {
        self.viewModel = viewModel
        self.state = .loading
    }
    
}

extension CurrencyListManager: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if state == .normal {
            return currenciesDict.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .loading:
            return 1
        case .searching:
            return currencyList.count
        case .normal:
            return currenciesDict[section].values.first?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if state == .loading {
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.identifier, for: indexPath) as! LoadingCell
            cell.setUpCell()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.identifier, for: indexPath) as! CurrencyCell
            cell.setUp()
            
            cell.code.text = state == .searching ?
                currencyList[indexPath.row].code :
                currenciesDict[indexPath.section].values.first?[indexPath.row].code
            
            cell.name.text = state == .searching ?
                currencyList[indexPath.row].currency :
                currenciesDict[indexPath.section].values.first?[indexPath.row].currency
            
            let quotation = state == .searching ?
                currencyList[indexPath.row].quotation :
                currenciesDict[indexPath.section].values.first?[indexPath.row].quotation
            
            let formatedQuotationString = "USD: \(quotation ?? 0.0)"
            cell.quotation.text = formatedQuotationString
            
            return cell
        }
    }
}

extension CurrencyListManager: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if state == .loading {
            return tableView.frame.size.height
        } else {
            return 55
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if state == .searching {
            selectedCurrency?(currencyList[indexPath.row])
        } else if state == .normal {
            guard let currency = currenciesDict[indexPath.section].values.first?[indexPath.row] else { return }
            selectedCurrency?(currency)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let currenciesDictKey = currenciesDict[section].keys.first, state != .loading {
            
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CurrencyListHeader.identifier) as! CurrencyListHeader
            header.setUpViews()
            header.label.text = state == .searching ? "Moedas" : currenciesDictKey
            
            return header
        } else {
            return UIView(frame: .zero)
            
        }
    }
}

extension CurrencyListManager: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        state = .searching
        
        currencyList = viewModel.filterCurrenciesDict(searchString: searchText.lowercased(), currenciesDict: currenciesDict)
        tableView?.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        state = .normal
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.endEditing(true)
        tableView?.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

