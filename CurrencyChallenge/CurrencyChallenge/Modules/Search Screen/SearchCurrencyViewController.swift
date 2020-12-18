//
//  ViewController.swift
//  CurrencyChallenge
//
//  Created by Higor Chaves Peres on 16/12/20.
//

import UIKit

class SearchCurrencyViewController: UIViewController, UICollectionViewDelegate {
    
    lazy var modelController = SearchCurrencyViewModelController(controller: self)
    lazy var currenciesDelegate = CurrenciesCollectionViewDelegate(controller: self)
    lazy var currenciesDataSource = CurrencyDataSource(controller: self)
    weak var delegate: SearchViewControllerDelegateSelectedCurrency?
    
    var searchCurrencies = [Currency]()
    var searching = false
    
    @IBOutlet weak var currenciesCollectionView: UICollectionView!
    @IBOutlet weak var currencySearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currenciesCollectionView.delegate = currenciesDelegate
        currenciesCollectionView.dataSource = currenciesDataSource
        modelController.updateSupportedCurrencies()
        currencySearchBar.delegate = self
    }
}

extension SearchCurrencyViewController : CurrenciesUpdateDelegate {
    func updateCurrencies() {
        DispatchQueue.main.async {
            self.currenciesDataSource.currencies = self.modelController.currencies
            self.currenciesCollectionView.reloadData()
        }
    }
}

extension SearchCurrencyViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchCurrencies.removeAll(keepingCapacity: false)
        searchCurrencies = currenciesDataSource.currencies.filter({$0.abbreviation.lowercased().contains(searchText.lowercased())})
        searching = (searchCurrencies.count == 0) ? false : true
        currenciesCollectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        currenciesCollectionView.reloadData()
    }
    
}
