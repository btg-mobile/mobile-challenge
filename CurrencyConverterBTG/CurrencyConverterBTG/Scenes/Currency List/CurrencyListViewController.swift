//
//  CurrencyListViewController.swift
//  CurrencyConverterBTG
//
//  Created by Silvia Florido on 18/06/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import UIKit

class CurrencyListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    weak var coordinator: MainCoordinator?
    
    private let currencyCellId = "currencyCell"
    var currencyList: [Currency] = [Currency]()
    var filteredCurrencyList: [Currency] = [Currency]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Moedas"
        configTableView()
        searchBar.delegate = self
        CurrencyLayerRepository.sharedInstance().getCurrenciesList { (response, error) in
            if let currencies = response?.currencies {
                self.currencyList = currencies
                self.filteredCurrencyList = currencies
                self.tableView.reloadData()
            } else {
                //display error
            }
        }
    }
    
    private func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        let currencyCellNib = UINib(nibName: "CurrencyTableViewCell", bundle: Bundle(for: type(of: self)))
        tableView.register(currencyCellNib, forCellReuseIdentifier: currencyCellId)
    }
    
    
    
    // MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCurrencyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: currencyCellId, for: indexPath) as! CurrencyTableViewCell
        cell.currencyCodeLabel.text = filteredCurrencyList[indexPath.row].code
        //            guard indexPath.row < filteredDestiniesList.count else {
        //                return cell
        //            }
        //            let destiny = filteredDestiniesList[indexPath.row]
        //
        //            cell.destView.title = destiny.name
        //            cell.destView.isSelected = destiny.selected
        //    //        cell.destView.tag = indexPath.row
        //            cell.destView.addTarget(self, action: #selector(didTapDestination), for: .touchUpInside)
        
        return cell
    }
    
    //        @objc func didTapDestination(_ sender: DestinationView) {
    //            guard let title = sender.title else { return }
    //            interactor?.updateDestiny(with: title, selected: sender.isSelected)
    //        }
    //
    //        // MARK: - InsuranceTagListViewDelegate
    //        func didRemoveTagWithTitle(_ title: String) {
    //    //        if let index = destiniesList.firstIndex(where: {  $0.name == title }) {
    //                interactor?.updateDestiny(with: title, selected: true)
    //    //        }
    //
    //        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
