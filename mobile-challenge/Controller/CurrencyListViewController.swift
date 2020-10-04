//
//  CurrencyListViewController.swift
//  mobile-challenge
//
//  Created by Brunno Andrade on 04/10/20.
//

import UIKit

enum TypeConverter: String {
    case origin
    case destiny
}

class CurrencyListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var typeConverter: TypeConverter?
    
    var viewModel = CurrencyListViewModel()
    private let cellIdentifier = "currencyCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.title
        
        setupTableView()
    }
    
    
    func setupTableView() -> Void {
        tableView.register(CurrencyUiTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

// MARK: Delegate and DataSource

extension CurrencyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CurrencyUiTableViewCell
        else { return CurrencyUiTableViewCell() }
        
        cell.setup(vm: viewModel)
        
        return cell
    }
    
}

