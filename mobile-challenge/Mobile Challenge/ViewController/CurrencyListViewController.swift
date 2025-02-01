//
//  CurrencyListViewController.swift
//  Mobile Challenge
//
//  Created by Vinicius Serpa on 16/11/24.
//

import UIKit

class CurrencyListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    let tableView = UITableView()
    let searchBar = UISearchBar()
    var safeArea: UILayoutGuide!
    let currencyVM: CurrencyViewModel = CurrencyViewModel()
    let conversionVM: ConversionViewModel = ConversionViewModel()
    var onCurrencySelected: ((String, Float) -> Void)?
    
    var isPrimarySelection: Bool = false
    var filteredCurrencies: [CurrencyNameModel] = []
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: ListView Configuration
    func setupTableView() {
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    
    func setupSearchBar() {
        searchBar.placeholder = "Buscar moeda"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    //MARK: UI Configuration Function
    func setupUI() {
        setupTableView()
        setupSearchBar()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        
        currencyVM.pullCurrencyNames { [weak self] in
            DispatchQueue.main.async {
                self?.filteredCurrencies = self?.currencyVM.currencyNames ?? []
                self?.tableView.reloadData()
            }
            
            self?.conversionVM.fetchConvertions()
        }
    }
    
    //MARK: TableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let currency = filteredCurrencies[indexPath.row]
        cell.textLabel?.text = "\(currency.code) - \(currency.name)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCurrency = filteredCurrencies[indexPath.row]
        
        if let conversion = conversionVM.convertions.first(where: { $0.code == selectedCurrency.code }) {
            onCurrencySelected?(conversion.code, conversion.dolarValue)
            navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: SearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredCurrencies = currencyVM.currencyNames
        } else {
            filteredCurrencies = currencyVM.currencyNames.filter { currency in
                currency.code.lowercased().contains(searchText.lowercased()) ||
                currency.name.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        filteredCurrencies = currencyVM.currencyNames
        tableView.reloadData()
    }
    
}

