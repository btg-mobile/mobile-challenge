//
//  CurrencyListViewController.swift
//  BTG Mobile Challange
//
//  Created by Uriel Barbosa Pinheiro on 23/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

import UIKit

class CurrencyListViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var currencylistTableView: UITableView!

    // MARK: - Constants

    private let tableViewCellIdentifier = "CurrencyListItemTableViewCell"
    private let errorTableViewCellIdentifier = "CurrencyListErrorTableViewCell"
    private let searchController = UISearchController(searchResultsController: nil)
    private let searchBarPlaceholder = "Filter by name or symbol..."

    // MARK: - Variables

    private var viewModel = CurrencyListViewModel(servicesProvider: CurrencyListServiceProvider())

    // MARK: - Lyfecycle and constructors

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewDelegate()
        setupSearchDelegate()
    }

    // MARK: - Private functions

    private func setupTableViewDelegate() {
        currencylistTableView.register(UINib(nibName: tableViewCellIdentifier, bundle: nil), forCellReuseIdentifier: tableViewCellIdentifier)
        currencylistTableView.register(UINib(nibName: errorTableViewCellIdentifier, bundle: nil), forCellReuseIdentifier: errorTableViewCellIdentifier)
        currencylistTableView.delegate = self
        currencylistTableView.dataSource = self
    }

    private func setupSearchDelegate() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = searchBarPlaceholder
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func filterResults() {
        guard let text = searchController.searchBar.text else { return }
        viewModel.filter(by: text)
        currencylistTableView.reloadData()
    }

    private func clearFilter() {
        viewModel.filter(by: String())
        currencylistTableView.reloadData()
    }
}

// MARK: - Extensions

extension CurrencyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currencyList?.count ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = currencylistTableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as? CurrencyListItemTableViewCell,
            let currency = viewModel.currencyList?[indexPath.row] else {
                let errorCell = currencylistTableView.dequeueReusableCell(withIdentifier: errorTableViewCellIdentifier, for: indexPath)
                currencylistTableView.separatorStyle = .none
                return errorCell
        }
        currencylistTableView.separatorStyle = .singleLine
        let countryName = currency.key
        let currencyCode = currency.value

        cell.countryNameLabel.text = countryName
        cell.currencyCodeLabel.text = currencyCode

        return cell
    }
}

extension CurrencyListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        filterResults()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filterResults()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearFilter()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            clearFilter()
        }
    }
}
