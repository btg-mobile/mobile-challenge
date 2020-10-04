//
//  CurrencyUiTableViewCell.swift
//  mobile-challenge
//
//  Created by Brunno Andrade on 04/10/20.
//

import UIKit

class CurrencyUiTableViewCell: UITableViewCell {
    
    var viewModel: CurrencyListViewModel? {
        didSet {
            textLabel?.text = "USD"
            detailTextLabel?.text = "5.68"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(vm: CurrencyListViewModel) {
        self.viewModel = vm
    }
    
}
