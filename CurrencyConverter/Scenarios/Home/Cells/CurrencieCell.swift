//
//  CurrencieCell.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 11/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Reusable
import UIKit

final class CurrencieCell: UITableViewCell, NibReusable {

    // MARK: - Outlets

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - Properties

    var model: CurrencieModel? {
        didSet {
            guard let model = model else {
                return
            }

            titleLabel.text = model.name
            descriptionLabel.text = model.nameFull
        }
    }
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
