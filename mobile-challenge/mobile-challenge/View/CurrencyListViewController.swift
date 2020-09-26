//
//  CurrencyListViewController.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 25/09/20.
//

import UIKit

class CurrencyListViewController: UIViewController, Storyboarded {
    
    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = "Pesquisar moeda"
        search.searchResultsUpdater = self
        search.hidesNavigationBarDuringPresentation = false
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        isModalInPresentation = true
        definesPresentationContext = true
        
        setupSearchBar()
    }

    func setupSearchBar() {
        navigationItem.titleView = searchController.searchBar
    }

}

extension CurrencyListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
}
