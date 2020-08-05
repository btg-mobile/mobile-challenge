//
//  CurrenciesListViewController.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 02/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import UIKit

class CurrenciesListViewController: UIViewController {
    @IBOutlet weak var currenciesFromTableView: UITableView!
    @IBOutlet weak var currenciesToTableView: UITableView!
    @IBOutlet weak var fromSearchBar: UISearchBar!
    @IBOutlet weak var toSearchBar: UISearchBar!
    
    var viewModel: CurrenciesListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableViews()
        viewModel = CurrenciesListViewModel()
    }
}

extension CurrenciesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == currenciesFromTableView {
            return viewModel?.getNumberOfRowsInSection(search: fromSearchBar.text) ?? 0
        } else {
            return viewModel?.getNumberOfRowsInSection(search: toSearchBar.text) ?? 0
        }
 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyViewCell.className, for: indexPath) as! CurrencyViewCell
        var search: String? = nil
        if tableView == currenciesFromTableView {
            search = fromSearchBar.text
        } else {
            search = toSearchBar.text
        }
        let currency = viewModel!.getCurrency(at: indexPath.row, search: search)
        cell.setCurrency(currency)
        return cell
    }
}

extension CurrenciesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar == fromSearchBar {
            currenciesFromTableView.reloadData()
        } else {
            currenciesToTableView.reloadData()
        }
    }
}

extension CurrenciesListViewController {
    func configTableViews() {
        currenciesFromTableView.register(UINib(nibName: CurrencyViewCell.className, bundle: nil), forCellReuseIdentifier: CurrencyViewCell.className)
        currenciesToTableView.register(UINib(nibName: CurrencyViewCell.className, bundle: nil), forCellReuseIdentifier: CurrencyViewCell.className)
    }
}
