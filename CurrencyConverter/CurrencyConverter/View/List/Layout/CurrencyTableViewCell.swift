//
//  CurrencyTableViewCell.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 30/10/20.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var subtitle: String? {
        get { subtitleLabel.text }
        set { subtitleLabel.text = newValue }
    }
    
    // MARK: - Layout Vars
    private lazy var titleLabel: UILabel = {
        let label = UILabel().useConstraint()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel().useConstraint()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel]).useConstraint()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    // MARK: - Life Cycle
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    // MARK: - Setups
    private func setupLayout() {
        contentView.backgroundColor = UIColor(displayP3Red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        contentView.addSubview(stackView)
        stackView
            .centerY(contentView.centerYAnchor)
            .leading(anchor: contentView.leadingAnchor, constant: 24)
            .trailing(anchor: contentView.trailingAnchor, constant: -24)
    }
}
