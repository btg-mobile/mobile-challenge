//
//  CurrencyListViewController.swift
//  CurrencyConverterBTG
//
//  Created by Alex Nascimento on 22/03/21.
//

import UIKit

final class CurrencyListViewController: UITableViewController {
    
    var viewModel: CurrencyListViewModel
    weak var coordinator: MainCoordinator?
    
    init(viewModel: CurrencyListViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.reusableIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = CurrencyTableViewCell.reusableIdentifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CurrencyTableViewCell else {
            preconditionFailure("No reusable cell registered with identifier: \(identifier)")
        }
        
        guard let currency = viewModel.currencies?[indexPath.row] else {
            preconditionFailure("No currencies")
        }
        
        cell.textLabel?.text = currency.name
        cell.detailTextLabel?.text = currency.code
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowsInSection
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.selectCurrency(currency: viewModel.currencies![indexPath.row])
    }
    
    func update() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
