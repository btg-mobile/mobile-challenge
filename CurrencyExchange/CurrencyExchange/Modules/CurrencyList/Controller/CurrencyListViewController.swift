//
//  CurrencyListViewController.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import UIKit

class CurrencyListViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: CurrencyListViewModel
    
    private var currencyListTableViewDataSource: CurrencyListTableViewDataSource? {
        didSet {
            guard let dataSource = currencyListTableViewDataSource else { return }
            
            self.currencyListView.tableView.dataSource = dataSource
            self.currencyListView.tableView.reloadData()
        }
    }
    
    private let currencyListView: CurrencyListView = {
        let view = CurrencyListView(frame: .zero)
        return view
    }()
    
    init(viewModel: CurrencyListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .red
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view  = currencyListView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.currencyListTableViewDataSource = CurrencyListTableViewDataSource()

    }
    
    
    // MARK: Lifecycle
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

