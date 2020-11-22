//
//  CurrencyListViewController.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import UIKit

class CurrencyListViewController: UIViewController {

    let tableView = CurrencyTableView()
    var manager: CurrencyTableViewManager?
    let currencyListViewModel = CurrencyListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        manager = CurrencyTableViewManager(currencyListViewModel: currencyListViewModel)
        
        currencyListViewModel.fetchCurrencies { (errors) in
            self.tableView.reloadData()
        }
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        tableView.delegate = manager
        tableView.dataSource = manager
    }

}
