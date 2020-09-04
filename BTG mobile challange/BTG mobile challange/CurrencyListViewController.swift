//
//  CurrencyListViewController.swift
//  BTG mobile challange
//
//  Created by Uriel Barbosa Pinheiro on 03/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

import UIKit

class CurrencyListViewController: UIViewController {

    let tableViewCellIdentifier = "CurrencyListItemTableViewCell"

    @IBOutlet weak var currencylistTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        currencylistTableView.register(UINib(nibName: tableViewCellIdentifier, bundle: nil), forCellReuseIdentifier: tableViewCellIdentifier)
        currencylistTableView.delegate = self
        currencylistTableView.dataSource = self
    }

}

extension CurrencyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = currencylistTableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as? CurrencyListItemTableViewCell else {
            return CurrencyListItemTableViewCell()
        }
        cell.countryNameLabel.text = "Estados Unidos"
        cell.currencyCodeLabel.text = "USD"
        return cell
    }
}

