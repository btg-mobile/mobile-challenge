//
//  CurrencyListViewController.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 25/09/20.
//

import UIKit

class CurrencyListViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    lazy var filterButton: UIBarButtonItem = {
        let button = UIButton()
        button.setTitle("Ordem: Nome", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        let barItem = UIBarButtonItem(customView: button)
        return barItem
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarBar()
        setupSearchBar()
    }

    func setupNavigationBarBar() {
        navigationItem.rightBarButtonItem = filterButton
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Pesquisar moeda"
    }
}

extension CurrencyListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.view.endEditing(true)
    }
}
