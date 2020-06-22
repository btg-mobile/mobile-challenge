//
//  CurrencyListViewController.swift
//  CurrencyConverterBTG
//
//  Created by Silvia Florido on 18/06/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import UIKit

protocol CurrencyListViewControllerDelegate: class {
    func didSelectCurrency(_ currency: Currency)
}

class CurrencyListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    weak var coordinator: MainCoordinator?
    weak var delegate: CurrencyListViewControllerDelegate?
    
    private let currencyCellId = "currencyCell"
    var currencyList: [Currency] = [Currency]()
    var filteredCurrencyList: [Currency] = [Currency]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Moedas Disponíveis"
        configTableView()
        configureBackButton()
        searchBar.delegate = self
        CurrencyLayerRepository.sharedInstance().getCurrenciesList { (response, error) in
            if let currencies = response?.currencies {
                self.currencyList = currencies
                self.filteredCurrencyList = currencies
                self.tableView.reloadData()
            } else {
                //display error - was implemented in the Conversion screen, sorry, not enough time. Should be a reusable component.
            }
        }
    }
    
    private func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        let currencyCellNib = UINib(nibName: "CurrencyTableViewCell", bundle: Bundle(for: type(of: self)))
        tableView.register(currencyCellNib, forCellReuseIdentifier: currencyCellId)
    }
    
    private func configureBackButton() {
        let closeButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backAction))
        let bundle = Bundle(for: CurrencyListViewController.self)
        if let image = UIImage(named: "ico-back-button", in: bundle, compatibleWith: nil)  {
            closeButton.image = image
            closeButton.tintColor = .black
            self.navigationItem.leftBarButtonItem = closeButton
        }
    }
    
    @objc func backAction(sender: UIBarButtonItem) {
        coordinator?.didFinishSelectingCurrency()
    }
    
    
    // MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCurrencyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: currencyCellId, for: indexPath) as! CurrencyTableViewCell
        
        let currency = filteredCurrencyList[indexPath.row]
        let viewModel = CurrencyViewModel(code: currency.code, name: currency.name, imageName: currency.code)
        cell.config(with: viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < filteredCurrencyList.count else {
            return
        }
        let selectedCurrency = filteredCurrencyList[indexPath.row]
        delegate?.didSelectCurrency(selectedCurrency)
        coordinator?.didFinishSelectingCurrency()
    }
    
    // MARK: - Search Bar - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterCurrencies(by: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        filterCurrencies(by: "")
    }
    
    
    private func filterCurrencies(by searchText: String) {
        let text = searchText.uppercased().folding(options: .diacriticInsensitive, locale: nil).trimmingCharacters(in: .whitespaces)
        let filtered = currencyList.filter{ $0.code.folding(options: .diacriticInsensitive, locale: nil).localizedCaseInsensitiveContains(text) || $0.name.folding(options: .diacriticInsensitive, locale: nil).localizedCaseInsensitiveContains(text)}
        
        filteredCurrencyList = text.count > 0 ? filtered : currencyList
        tableView.reloadData()
    }
}
