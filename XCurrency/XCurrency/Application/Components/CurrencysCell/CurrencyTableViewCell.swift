//
//  CurrencyTableViewCell.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 28/03/21.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var codeLabel: UILabel!

    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
