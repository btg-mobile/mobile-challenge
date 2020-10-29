//
//  CurrencyListTableViewDataSource.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import UIKit

class CurrencyListTableViewDataSource: NSObject, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyListTableViewCell.uniqueIdentifier, for: indexPath) as? CurrencyListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setupCurrency(withName: "Testando")
        
        
        return cell
    }
    
    
}
