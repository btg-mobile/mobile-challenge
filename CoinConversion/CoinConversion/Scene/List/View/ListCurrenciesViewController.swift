//
//  ListCurrenciesViewController.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 19/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import UIKit

// MARK: - Main
class ListCurrenciesViewController: UITableViewController {
    
    var viewModel: ListCurrenciesViewModel?
    
    init(viewModel: ListCurrenciesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: ListCurrenciesViewController.nibName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewController lifecycle
extension ListCurrenciesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = .colorBackground
        
        setupNavigationBar()
        setupBarButton()
        registerTableView()
        
        viewModel?.delegate = self
        viewModel?.fetchListCurrencies()
    }
}

// MARK: - Private methods
extension ListCurrenciesViewController {
    private func searchController() -> UISearchController {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.delegate = self
        
        let searchBar = searchController.searchBar
        searchBar.tintColor = .white
        searchBar.barTintColor = .white
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.textColor = .colorGrayPrimary
        searchBar.searchTextField.layer.cornerRadius = 10
        searchBar.searchTextField.clipsToBounds = true
        
        return searchController
    }
    
    private func setupNavigationBar() {
        configureNavigationBar(largeTitleColor: .white,
                               backgoundColor: .colorDarkishPink,
                               tintColor: .white,
                               title: "Lista de moedas",
                               preferredLargeTitle: true,
                               isSearch: true,
                               searchController: searchController()
        )
    }
    
    private func registerTableView() {
        tableView.register(
            UINib(nibName: ListCurrenciesSectionViewCell.identifier, bundle: nil),
            forHeaderFooterViewReuseIdentifier: ListCurrenciesSectionViewCell.identifier
        )
        tableView.register(
            UINib(nibName: ListCurrenciesViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ListCurrenciesViewCell.identifier
        )
    }
    
    private func setupBarButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonTouched(sender:)))
        button.tintColor = .white
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func refreshButtonTouched(sender: UIBarButtonItem) {
         viewModel?.fetchListCurrencies()
    }
}

// MARK: - UISearchResultsUpdating
extension ListCurrenciesViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            print(text)
        }
    }
}

// MARK: - UITableViewDataSource
extension ListCurrenciesViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listCurrencies = viewModel?.listCurrencies else {
            return 0
        }
        return listCurrencies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCurrenciesViewCell.identifier, for: indexPath) as? ListCurrenciesViewCell else {
            fatalError("Couldn't dequeue \(ListCurrenciesViewCell.identifier)")
        }
        
        guard let listCurrencies = viewModel?.listCurrencies else {
            return UITableViewCell()
        }
        
        let currencies = listCurrencies[indexPath.row]
        cell.bind(
            name: currencies.name,
            currency: currencies.currency
        )
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: ListCurrenciesSectionViewCell.identifier) as? ListCurrenciesSectionViewCell else {
            fatalError("Couldn't dequeue \(ListCurrenciesSectionViewCell.identifier)")
        }

        if !(viewModel?.isSort ?? false) {
            cell.setupRadioButtons(tag: 0, buttons: cell.sortByNameButton)
        }
        
        cell.delegate = self
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListCurrenciesViewController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 82
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - ListCurrenciesSectionViewCellDelegate
extension ListCurrenciesViewController: ListCurrenciesSectionViewCellDelegate {
    func didTapSortBy(_ sortType: SortType) {
        
        guard let listCurrencies = viewModel?.listCurrencies else {
            fatalError("listCurrencies cannot be null")
        }
        
        viewModel?.sortBy(sortType, with: listCurrencies)
    }
}

// MARK: - ListCurrenciesViewModelDelegate
extension ListCurrenciesViewController: ListCurrenciesViewModelDelegate {
    func didStartLoading() {
        showActivityIndicator()
    }
    
    func didHideLoading() {
        hideActivityIndicator()
    }
    
    func didReloadData() {
        UIView.transition(with: self.tableView, duration: 0.35, options: .transitionCrossDissolve, animations: {
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: IndexPath(row: NSNotFound, section: 0), at: .top, animated: true)
        })
    }
    
    func didFail() {
        
    }
}
