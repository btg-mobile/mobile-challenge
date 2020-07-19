//
//  ListCurrenciesSectionViewCell.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 19/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import UIKit

class ListCurrenciesSectionViewCell: UITableViewHeaderFooterView {
    
    @IBOutlet private var typeSortButton: RadioButton! {
        didSet {
            typeSortButton.iconColor = .colorGrayLighten60
            typeSortButton.indicatorColor = .colorDarkishPink
            typeSortButton.iconBackgroundColor = .colorGrayLighten70
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
