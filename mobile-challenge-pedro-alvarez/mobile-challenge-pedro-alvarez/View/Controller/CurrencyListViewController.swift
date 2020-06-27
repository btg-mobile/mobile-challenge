//
//  CurrencyListViewController.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 27/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class CurrencyListViewController: UIViewController {
    
    private(set) var factory: CurrencyTableViewFactory?
    
    private(set) var dataSource: DefaultTableViewOutput?
    
    private(set) var viewModel: CurrencyListViewModelProtocol?
    
    private lazy var tableView: CurrencyListTableView = {
        return CurrencyListTableView(frame: .zero)
    }()
    
    private lazy var mainView: CurrencyListView = {
        return CurrencyListView(frame: .zero,
                                tableView: tableView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    
}

extension CurrencyListViewController {
    
    private func setupDataSource() {
        
    }
    
    private func setupTableView() {
        guard let dataSource = dataSource else { return }
        tableView.assignProtocols(to: dataSource)
    }
    
    private func setupFactory() {
        guard let viewModel = viewModel else { return }
        factory = CurrencyTableViewFactory(viewModel: viewModel)
        guard let sections = factory?.buildSections() else { return }
        dataSource = DefaultTableViewOutput(sections: sections)
    }
}

extension CurrencyListViewController: CurrencyListViewModelDelegate {
    
    func didFetchCurrencies() {
        
    }
    
    func didFetchSelectedCurrency(id: String) {
        
    }
    
    func didGetError(_ error: String) {
        
    }
}
