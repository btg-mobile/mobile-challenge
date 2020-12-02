//
//  CurrencyListViewController.swift
//  mobile-challenge
//
//  Created by gabriel on 01/12/20.
//

import UIKit

class CurrencyListViewController: UIViewController {
    
    private let cellIdentifier = "CurrencyTableViewCell"
    
    // MARK: Data dependencies
    private let currencyList: CurrencyList
    private var filteredCurrencyList: [Currency]
    
    // MARK: Binding methods
    var selectedItem: ((Currency) -> Void)
    
    // MARK: UI Elements
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.separatorColor = .systemGray6
        tableView.separatorInset = .zero
        return tableView
    }()
    
    private let searchController: UISearchController = UISearchController()
    
    // MARK: Init
    init(currencyList: CurrencyList, selectedItem: @escaping ((Currency) -> Void)) {
        self.currencyList = currencyList
        self.filteredCurrencyList = currencyList.currencies
        self.selectedItem = selectedItem
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        // Not used because of view code
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.delegate = self
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: Setup methods
    private func setupUI() {
        self.title = "Selecione uma moeda"
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        setupTableView()
        setupTableViewConstraints()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
                
        view.addSubview(tableView)
    }
    
    private func setupTableViewConstraints() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension CurrencyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem(filteredCurrencyList[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}

extension CurrencyListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCurrencyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let name = filteredCurrencyList[indexPath.row].name
        let symbol = filteredCurrencyList[indexPath.row].symbol
        
        let cell = CurrencyTableViewCell()
        cell.setup(for: name, and: symbol)
                
        return cell
    }
}

extension CurrencyListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchText = searchText.lowercased()
        let filtered = currencyList.currencies.filter({
            // Query by name or symbol
            $0.name.lowercased().contains(searchText) || $0.symbol.lowercased().contains(searchText)
        })
        self.filteredCurrencyList = filtered.isEmpty ? currencyList.currencies : filtered
        tableView.reloadData()
    }
}
