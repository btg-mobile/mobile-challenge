//
//  CurrencySearchViewController.swift
//  btg-challenge
//
//  Created by Wesley Araujo on 13/09/20.
//  Copyright © 2020 Wesley Araujo. All rights reserved.
//

import UIKit

class CurrencySearchViewController: BaseViewController<CurrencySearchViewModel> {

    @IBOutlet weak var currenciesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchController: UISearchController?
    var mockCurrencies = ["USD": "Dollar", "BRL": "Real"]
    var currencies: [String: String]?
    var filteredCurrencies: [String: String] = [String: String]()
    var isSourceCurrencyActionCaller = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        associetedViewModel?.getAvailableCurrencies()
        searchBar.delegate = self
        currenciesTableView.delegate = self
        currenciesTableView.dataSource = self
    }
    
    func setCurrencies(_ currencies: Currencies) {
        self.currencies = currencies.currencies
        self.filteredCurrencies = self.currencies!
        DispatchQueue.main.async {
            self.currenciesTableView.reloadData()
        }
    }

}

extension CurrencySearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredCurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CurrencyTableViewCell.self)", for: indexPath) as! CurrencyTableViewCell
        cell.currencyCodeLabel.text = Array(filteredCurrencies)[indexPath.row].key
        cell.currencyNameLabel.text = Array(filteredCurrencies)[indexPath.row].value
        return cell
    }
}

extension CurrencySearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCurrency = Array(filteredCurrencies)[indexPath.row]
        associetedViewModel?.didPickCurrency(selectedCurrency)
        dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94.0
    }
}

extension CurrencySearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let isSearchTextNotEmpty = searchText.isEmpty == false
        let trimmedSearchText = searchText.replacingOccurrences(of: " ", with: "") // For ignore whitespace
        
        if let currencies = self.currencies {
            if isSearchTextNotEmpty {
                filteredCurrencies = currencies.filter { $0.key.lowercased().contains(trimmedSearchText.lowercased()) || $0.value.lowercased().contains(trimmedSearchText.lowercased()) }
            } else {
                filteredCurrencies = currencies
            }
        }
        
        currenciesTableView.reloadData()
    }
}
