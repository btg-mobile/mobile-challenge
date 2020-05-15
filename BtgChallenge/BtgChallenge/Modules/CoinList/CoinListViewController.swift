//
//  CoinListViewController.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 13/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import UIKit

protocol CoinListCoordinatorDelegate: class {
    
}

class CoinListViewController: UIViewController {

    // MARK: - Constants
    
    static let searchBarPlaceholder = "Search coin..."
    
    // MARK: - Properties
    
    var coinListView: CoinListView?
    var viewModel: CoinListViewModelInput?
    var coordinator: CoinListCoordinatorDelegate?
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = CoinListViewController.searchBarPlaceholder
        
        return searchController
    }()
    
    var isSearchEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    init(viewModel: CoinListViewModelInput, coordinator: CoinListCoordinatorDelegate) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        super.loadView()
        coinListView = CoinListView(viewController: self)
        view = coinListView
        title = "Select Coin"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.searchController = searchController
        
        viewModel?.viewDidLoad()
    }

}

extension CoinListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel?.searchForCoin(string: searchController.searchBar.text ?? "")
    }
}

extension CoinListViewController: CoinListViewModelOutput {
    func displayCoinList(viewModel: CoinListTableViewModel) {
        coinListView?.coinListTableView.update(viewModel: viewModel)
    }
}
