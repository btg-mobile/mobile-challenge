//
//  CurrencyCell.swift
//  CurrencyConverter
//
//  Created by Eduardo Lopes on 30/09/21.
//

import UIKit

final class CurrencyCell: UITableViewCell {
    
    var container: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CurrencyCell: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews([container])
    }
    
    func setupConstraints() {
        [
            container.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
        ].activate()
    }
    
    func configureViews() {
    }
}
