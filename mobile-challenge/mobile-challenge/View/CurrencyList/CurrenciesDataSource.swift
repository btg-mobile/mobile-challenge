//
//  CurreenciesDataSource.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import UIKit

class CurrenciesDataSource: NSObject, UITableViewDataSource {
    var viewModel: CurrencyListViewModel
    
    init(viewModel: CurrencyListViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CurrencyTableViewCell
        let currency = viewModel.currencies[indexPath.row]
        cell.codeLabel.text = currency.code
        cell.nameLabel.text = currency.name

        if let valueDolar = currency.valueDollar {
            cell.toCurrencyLabel.text = currency.code
            cell.valueDollarLabel.text = "\(valueDolar)"
        }
        else {
            cell.toCurrencyLabel.text = ""
            cell.valueDollarLabel.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard
            let date = viewModel.dateExchange else {
            return ""
        }
        
        return "Cotação de \(date.string)"
    }
}
