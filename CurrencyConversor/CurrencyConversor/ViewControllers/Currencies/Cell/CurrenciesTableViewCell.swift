//
//  CurrenciesTableViewCell.swift
//  CurrencyConversor
//
//  Created by Erick Mitsugui Yamato on 10/11/20.
//

import UIKit

class CurrenciesTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(code: String, name: String) {
        codeLabel.text = code
        nameLabel.text = name
    }
}
