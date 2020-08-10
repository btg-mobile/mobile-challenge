//
//  CurrenciesViewController.swift
//  BTGPactual-HelioVieira
//
//  Created by Helio Junior on 10/08/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import UIKit

final class CurrenciesViewController: UIViewController {
    
    // MARK: Properties
    let searchController = UISearchController(searchResultsController: nil)
    private var mode: CurrencyMode!
    private var currencies: [Currency] = []
    private var showCurrencies: [Currency] = []
    enum CurrencyMode {
        case input
        case output
    }
    var didSelectCurrency: ((Currency) -> ())?
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.register(UINib(nibName: CurrencyNameCell.identifier, bundle: nil), forCellReuseIdentifier: CurrencyNameCell.identifier)
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    // MARK: Builder
    class func builder(mode: CurrenciesViewController.CurrencyMode, currencies: [Currency]) -> CurrenciesViewController {
        let viewController = CurrenciesViewController().instantiate() as! CurrenciesViewController
        viewController.mode = mode
        viewController.currencies = currencies
        return viewController
    }
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = mode == .input ? "Currency Input" : "Currency Output"
        showCurrencies = currencies
        configureSearchController()
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: Helpers
    func configureSearchController() {
        navigationItem.searchController = self.searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Pesquisar..."
        searchController.searchBar.delegate = self
    }
}

// MARK: Extensions
extension CurrenciesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showCurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyNameCell.identifier) as? CurrencyNameCell else {return UITableViewCell()}
        
        let currency = showCurrencies[indexPath.row]
        cell.setup(with: currency)
        return cell
    }
}

extension CurrenciesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.becomeFirstResponder()
        let currency = showCurrencies[indexPath.row]
        self.didSelectCurrency?(currency)
        self.navigationController?.popViewController(animated: true)
    }
}

extension CurrenciesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        showCurrencies = currencies.filter({ $0.code.lowercased().contains(searchText.lowercased()) ||
                                            $0.name.lowercased().contains(searchText.lowercased()) })
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.becomeFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        showCurrencies = currencies
        tableView.reloadData()
        self.becomeFirstResponder()
    }
}
