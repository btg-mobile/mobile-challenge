//
//  ListViewCurrency.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import UIKit

class ListViewCurrency: UITableViewController {
    var presenter: ListCurrencyPresenterInput!
    let cellId = "CellID"
    var viewModels: [ListViewModel] = [ListViewModel]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupLayout()
    }
    
    func setupLayout(){
        title = "Lista de moedas"
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle , reuseIdentifier: cellId)
        let viewModel = viewModels[indexPath.row]
        cell.textLabel?.text = viewModel.currency
        cell.detailTextLabel?.text = viewModel.name
        cell.imageView?.image = viewModel.imageView
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelected(viewModel: viewModels[indexPath.row])
    }
}

extension ListViewCurrency: ListCurrencyPresenterOuput {
    
    func loadView(viewModels: [ListViewModel]) {
        self.viewModels = viewModels
    }
}
