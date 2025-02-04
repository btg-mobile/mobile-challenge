//
//  TableViewCurrency.swift
//  MobileChallenge
//
//  Created by Gabriel Vicentin Negro on 20/11/24.
//

import Foundation
import UIKit

class TableViewCurrencyDataSource: NSObject, UITableViewDataSource {
    
    var listOfCurrencyNames: [String]
    var listOfCurrencyCodes: [String]

    init(listOfCurrencyNames: [String], listOfCurrencyCodes: [String]) {
        self.listOfCurrencyNames = listOfCurrencyNames
        self.listOfCurrencyCodes = listOfCurrencyCodes
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfCurrencyNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCurrencyCell.identifier, for: indexPath) as? TableViewCurrencyCell else {
            fatalError("The TableView could not dequeue a TableViewCurrencyCell in ViewController")
        }
        
        let currencyName = listOfCurrencyNames[indexPath.row]
        let currencyCode = listOfCurrencyCodes[indexPath.row]
        
        cell.configure(currencyName: currencyName, currencyCode: currencyCode)
        
        
        return cell
        
    }
    
}
