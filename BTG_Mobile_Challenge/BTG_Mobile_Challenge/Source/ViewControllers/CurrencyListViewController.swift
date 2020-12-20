//
//  CurrencyListViewController.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 20/12/20.
//

import UIKit

final class CurrencyListViewController: UIViewController {
    
    private lazy var pickerTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private lazy var tableViewDelegate: CurrencyListTableViewDelegate = CurrencyListTableViewDelegate { [weak self] (cell) in 
        self?.viewModel.swapCurrencies(newCode: cell.currencyID, newName: cell.currencyName)
    }
    
    private lazy var tableViewDataSource: CurrencyListTableViewDataSource = CurrencyListTableViewDataSource(viewModel: viewModel)

    private let viewModel: CurrencyListViewModel
        
    init(viewModel: CurrencyListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        guard let viewModel = coder.decodeObject(forKey: "viewModel") as? CurrencyListViewModel else {
            return nil
        }
        self.init(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupTableViewConstraints()
    }
    
    private func setupTableViewConstraints() {
        self.view.addSubview(pickerTableView)
        pickerTableView.addAnchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, widht: nil, height: nil)
    }
}
