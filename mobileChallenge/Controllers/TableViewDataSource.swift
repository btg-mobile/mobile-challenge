//
//  TableViewDataSource.swift
//  mobileChallenge
//
//  Created by Henrique on 05/02/25.
//

import Foundation
import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource{
    
    var currencies: [CurrencyName]
    
    init(currencies: [CurrencyName]){
        self.currencies = currencies
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = ("\(currencies[indexPath.row].code) -  \((currencies[indexPath.row].name))")
        return cell
    }
    
    
}
