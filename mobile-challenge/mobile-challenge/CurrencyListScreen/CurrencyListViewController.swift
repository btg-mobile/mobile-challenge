//
//  CurrencyListViewController.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import UIKit

class CurrencyListViewController: UIViewController {

    let currencyListView = CurrencyListView()
    var manager: CurrencyTableViewManager?
    let currencyListViewModel = CurrencyListViewModel()
    weak var selectDelegate: SelectCurrencyDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        manager = CurrencyTableViewManager(currencyListViewModel: currencyListViewModel)
        
        view = currencyListView
        view.backgroundColor = .systemBackground
        
        setupTableView()
        setupClosures()
        setupSearchBar()
        
        currencyListViewModel.fetchCurrencies { (errors) in
            DispatchQueue.main.async {
                self.currencyListView.tableView.reloadData()
            }
        }
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = manager
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar"
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
    }
    
    private func setupClosures() {
        currencyListView.changeOrder = { [weak self] in
            self?.manager?.changeOrder()
        }
        
        manager?.didSelectCurrency = { [weak self] currency in
            self?.selectDelegate?.getCurrency(currency: currency)
            self?.navigationController?.popViewController(animated: true)
        }
        
        manager?.refreshSearch = { [weak self] in
            self?.currencyListView.tableView.reloadData()
        }
    }
    
    private func setupTableView() {        
        currencyListView.tableView.delegate = manager
        currencyListView.tableView.dataSource = manager
    }
}
