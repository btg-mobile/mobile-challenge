//
//  CurrencyTableViewCell.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    static let identifier = "CurrencyTableViewCellID"
    
    var currency: CurrencyModel? {
        didSet{
            currencyLabel.text = "\(currency?.code ?? "") | \(currency?.name ?? "")"
        }
    }
    
    var currencyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

extension CurrencyTableViewCell: ViewCodable {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            currencyLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            currencyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            currencyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            currencyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10)
        ])
    }
    
    func setupViewHierarchy() {
        contentView.addSubview(currencyLabel)
    }
}
