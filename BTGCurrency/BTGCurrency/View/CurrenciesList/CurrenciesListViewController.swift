//
//  CurrenciesListViewController.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 02/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import UIKit

class CurrenciesListViewController: UIViewController {
    @IBOutlet weak var currenciesFromTableView: UITableView!
    @IBOutlet weak var currenciesToTableView: UITableView!
    
    var viewModel: CurrenciesListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableViews()
        viewModel = CurrenciesListViewModel()
    }

}

extension CurrenciesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyViewCell.className, for: indexPath) as! CurrencyViewCell
        let currency = viewModel!.getCurrency(at: indexPath.row)
        cell.title.text = currency.name
        return cell
    }
}

extension CurrenciesListViewController {
    func configTableViews() {
        currenciesFromTableView.register(UINib(nibName: CurrencyViewCell.className, bundle: nil), forCellReuseIdentifier: CurrencyViewCell.className)
        currenciesToTableView.register(UINib(nibName: CurrencyViewCell.className, bundle: nil), forCellReuseIdentifier: CurrencyViewCell.className)
    }
}
