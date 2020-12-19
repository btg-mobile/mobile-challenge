//
//  CurrencyListUITableViewCell.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 19/12/20.
//

import UIKit

final class CurrencyListUITableViewCell: UITableViewCell {
    
    private var currency: CurrencyResponseFromList
    
    init(currency: CurrencyResponseFromList) {
        self.currency = currency
        super.init(style: .default, reuseIdentifier: CurrencyListUITableViewCell.cellID())
    }
    
    internal required convenience init?(coder: NSCoder) {
        guard let currency = coder.decodeObject(forKey: "currency") as? CurrencyResponseFromList else {
            return nil
        }
        self.init(currency: currency)
    }
    
    internal class func cellID() -> String {
        "CurrencyListUITableViewCell"
    }
}
