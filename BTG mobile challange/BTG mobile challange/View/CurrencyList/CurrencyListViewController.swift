//
//  CurrencyListViewController.swift
//  BTG mobile challange
//
//  Created by Uriel Barbosa Pinheiro on 03/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

import UIKit

class CurrencyListViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var currencylistTableView: UITableView!

    // MARK: - Constants

    let tableViewCellIdentifier = "CurrencyListItemTableViewCell"

    // MARK: - Variables

    private var viewModel = CurrencyListViewModel(servicesProvider: CurrencyListServiceProvider())

    // MARK: - Lyfecycle and constructors

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewDelegate()
    }

    // MARK: - Private functions

    private func setupTableViewDelegate() {
        currencylistTableView.register(UINib(nibName: tableViewCellIdentifier, bundle: nil), forCellReuseIdentifier: tableViewCellIdentifier)
        currencylistTableView.delegate = self
        currencylistTableView.dataSource = self
    }
}

// MARK: - Extensions

extension CurrencyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currencyList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = currencylistTableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as? CurrencyListItemTableViewCell else {
            return CurrencyListItemTableViewCell()
        }
        let currency = viewModel.currencyList?[indexPath.row]
        let countryName = currency?.key
        let currencyCode = currency?.value

        cell.countryNameLabel.text = countryName
        cell.currencyCodeLabel.text = currencyCode

        return cell
    }
}

