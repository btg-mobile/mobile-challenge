//
//  CurrencyTableViewCell.swift
//  CurrencyConverterBTG
//
//  Created by Silvia Florido on 19/06/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var currencyView: CurrencyView!
    override func awakeFromNib() {
        super.awakeFromNib()
        currencyView.isUserInteractionEnabled = false
    }
    
    func config(with viewModel: CurrencyViewModel) {
        currencyView.config(with: viewModel)
    }
  
}

