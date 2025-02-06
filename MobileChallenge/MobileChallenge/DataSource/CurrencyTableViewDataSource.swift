//
//  CurrencyTableViewDataSource.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 04/02/25.
//

import Foundation
import UIKit

class CurrencyTableViewDataSource: NSObject, UITableViewDataSource {
    
    var currencyResponse: [(String, String)]
    
    init(currencyResponse: [(String, String)]) {
        self.currencyResponse = currencyResponse
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier, for: indexPath) as? CurrencyTableViewCell else {
            fatalError("failed to create cell")
        }
        
        let currency = currencyResponse[indexPath.row]

        cell.configureCell(name: currency.1, code: currency.0)

        return cell
        
    }
    
    
}
