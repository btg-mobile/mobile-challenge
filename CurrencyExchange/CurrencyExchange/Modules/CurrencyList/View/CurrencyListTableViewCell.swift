//
//  CurrencyListTableViewCell.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import UIKit

class CurrencyListTableViewCell: UITableViewCell, Identifiable {
    
    private let currencyNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = ""
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    func setupCurrency(withName name: String){
        self.currencyNameLabel.text = name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - View Codable Protocol

extension CurrencyListTableViewCell: ViewCodable {
    
    func setupViewHierarchy() {
        addSubview(currencyNameLabel)
    }
    
    func setupConstraints() {
        setupCurrencyNameLabelConstraints()
    }
    
    private func setupCurrencyNameLabelConstraints(){
        currencyNameLabel.centerY(in: self)
        currencyNameLabel.anchor(left: leftAnchor, paddingLeft: ScreenSize.width * 0.06)
    }
    
}
