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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        manager = CurrencyTableViewManager(currencyListViewModel: currencyListViewModel)
        
        view = currencyListView
        view.backgroundColor = .systemBackground
        
        setupTableView()
        setupClosures()
        
        currencyListViewModel.fetchCurrencies { (errors) in
            DispatchQueue.main.async {
                self.currencyListView.tableView.reloadData()
            }
        }
    }
    
    private func setupClosures() {
        currencyListView.changeOrder = { [weak self] in
            self?.manager?.changeOrder()
        }
        
        manager?.didSelectCurrency = { [weak self] currency in
            self?.dismiss(animated: true, completion: nil)
        }
        
    }
    
    private func setupTableView() {        
        currencyListView.tableView.delegate = manager
        currencyListView.tableView.dataSource = manager
    }
}
