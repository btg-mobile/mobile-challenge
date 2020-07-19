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
        
        configureNavigationBar(largeTitleColor: .white,
                               backgoundColor: .colorDarkishPink,
                               tintColor: .white,
                               title: "Lista de moedas",
                               preferredLargeTitle: true,
                               isSearch: true,
                               searchController: searchController()
        )
        tableView.register(
            UINib(nibName: ListCurrenciesSectionViewCell.identifier, bundle: nil),
            forHeaderFooterViewReuseIdentifier: ListCurrenciesSectionViewCell.identifier
        )
        setupBarButton()
        viewModel?.delegate = self
        
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
    
    private func setupBarButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: #selector(self.refreshButtonTouched))
        button.tintColor = .white
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private dynamic func refreshButtonTouched() {
        
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
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: ListCurrenciesSectionViewCell.identifier) as? ListCurrenciesSectionViewCell
            return cell

    }
}

// MARK: - UITableViewDelegate
extension ListCurrenciesViewController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 82
    }
}

// MARK: - ListCurrenciesViewModelDelegate
extension ListCurrenciesViewController: ListCurrenciesViewModelDelegate {
    func didStartLoading() {
        
    }
    
    func didHideLoading() {
        
    }
    
    func didReloadData() {
        
    }
    
    func didFail() {
        
    }
}
