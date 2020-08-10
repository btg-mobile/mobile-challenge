//
//  CurrencyNameCell.swift
//  BTGPactual-HelioVieira
//
//  Created by Helio Junior on 10/08/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import UIKit

class CurrencyNameCell: UITableViewCell {
    
    static let identifier = "CurrencyNameCell"

    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setup(with currency: Currency) {
        lblCode.text = currency.code
        lblName.text = currency.name
    }
}
