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
        self.orderCurrencies(by: .code)
    }
    
    func orderCurrencies(by: OrderButtonTitle) {
        switch by {
        case .code:
            viewModel.currencies.sort { $0.code < $1.code }
        case .name:
            viewModel.currencies.sort { $0.name < $1.name }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let currency = viewModel.currencies[indexPath.row]
        cell.textLabel?.text = "\(currency.code) - \(currency.name)"
        
        if let valueDolar = currency.valueInDollar {
            cell.detailTextLabel?.text = "USD-\(currency.code): \(valueDolar)"
        }
        else {
            cell.detailTextLabel?.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard
            let currency = viewModel.currencies.first,
            let date = currency.date else {
            return ""
        }
        
        return "Cotação de \(date.string)"
    }
}
