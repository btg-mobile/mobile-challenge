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
    let errorTableViewCellIdentifier = "CurrencyListErrorTableViewCell"

    // MARK: - Variables

    private var viewModel = CurrencyListViewModel(servicesProvider: CurrencyListServiceProvider())
    var refreshControl = UIRefreshControl()

    // MARK: - Lyfecycle and constructors

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewDelegate()
        setupTableViewRefresh()
    }

    // MARK: - Private functions

    private func setupTableViewDelegate() {
        currencylistTableView.register(UINib(nibName: tableViewCellIdentifier, bundle: nil), forCellReuseIdentifier: tableViewCellIdentifier)
        currencylistTableView.register(UINib(nibName: errorTableViewCellIdentifier, bundle: nil), forCellReuseIdentifier: errorTableViewCellIdentifier)
        currencylistTableView.delegate = self
        currencylistTableView.dataSource = self
    }

    private func setupTableViewRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh data")
        refreshControl.addTarget(self, action: #selector(self.refreshTableView(_:)), for: .valueChanged)
        currencylistTableView.addSubview(refreshControl)
    }

    @objc private func refreshTableView(_ sender: AnyObject) {
        currencylistTableView.reloadData()
        refreshControl.endRefreshing()
    }
}

// MARK: - Extensions

extension CurrencyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currencyList?.count ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = currencylistTableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as? CurrencyListItemTableViewCell,
            let currency = viewModel.currencyList?[indexPath.row] else {
                let errorCell = currencylistTableView.dequeueReusableCell(withIdentifier: errorTableViewCellIdentifier, for: indexPath)
                currencylistTableView.separatorStyle = .none
                return errorCell
        }
        currencylistTableView.separatorStyle = .singleLine
        let countryName = currency.key
        let currencyCode = currency.value

        cell.countryNameLabel.text = countryName
        cell.currencyCodeLabel.text = currencyCode

        return cell
    }
}

