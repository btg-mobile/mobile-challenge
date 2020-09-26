//
//  CurreenciesDataSource.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import UIKit

class CurreenciesDataSource: NSObject, UITableViewDataSource {
    var currencies: [CurrencyModel]
    
    init(currencies: [CurrencyModel]) {
        self.currencies = currencies
        super.init()
        self.orderCurrencies(by: .code)
    }
    
    func orderCurrencies(by: OrderButtonTitle) {
        switch by {
        case .code:
            currencies.sort { $0.code < $1.code }
        case .name:
            currencies.sort { $0.name < $1.name }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let currency = currencies[indexPath.row]
        cell.textLabel?.text = "\(currency.code) - \(currency.name)"
        return cell
    }
    
    
}
