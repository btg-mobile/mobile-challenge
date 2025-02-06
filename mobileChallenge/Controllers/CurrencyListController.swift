//
//  CurrencyListController.swift
//  mobileChallenge
//
//  Created by Henrique on 04/02/25.
//

import Foundation
import UIKit

class CurrencyListController: UIViewController, UISearchResultsUpdating {
    
    weak var delegate: CurrencyListProtocol?

    var homeControllerViewModel: HomeControllerViewModel
    var viewModel: CurrencyListControllerViewModel
    
    var selectedOptionCurrency: Int
    
    var filteredCurrencies: [CurrencyName] = []
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    lazy var tableViewDelegate = TableViewDelegate(currencies: homeControllerViewModel.currency, currencyConversion: homeControllerViewModel.currencyConversion)
    lazy var tableViewDataSource = TableViewDataSource(currencies: homeControllerViewModel.currency)
    
    init(homeControllerViewModel: HomeControllerViewModel = HomeControllerViewModel(), viewModel: CurrencyListControllerViewModel = CurrencyListControllerViewModel(), selected: Int = 1) {
        self.homeControllerViewModel = homeControllerViewModel
        self.viewModel = viewModel
        self.selectedOptionCurrency = selected
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupTableView()
        setupSearchController()
        tableViewDelegate.onSelectedCurrency = { [weak self] currency in
            if self?.selectedOptionCurrency == 1{
                self?.homeControllerViewModel.firstCurrencyValue = currency.value
                self?.delegate?.selectedCurrency(code: currency.code.replacingOccurrences(of: "USD", with: ""), selected: 1)
            }
            else {
                self?.homeControllerViewModel.secondCurrencyValue = currency.value
                self?.delegate?.selectedCurrency(code: currency.code.replacingOccurrences(of: "USD", with: ""), selected: 2)
            }
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Procure uma moeda"
        
        self.navigationItem.searchController = self.searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if viewModel.inSearchMode(searchController){
            self.filteredCurrencies = homeControllerViewModel.currency
            viewModel.updateSearchController(searchBarText: searchController.searchBar.text, filteredCurrencies: &filteredCurrencies)
            self.tableViewDataSource.currencies = self.filteredCurrencies
            self.tableViewDelegate.currencies = self.filteredCurrencies
        } else {
            self.tableViewDataSource.currencies = homeControllerViewModel.currency
            self.tableViewDelegate.currencies = homeControllerViewModel.currency
        }
        tableView.reloadData()
    }
    
    
    
}

