//
//  TableViewCurrencyCell.swift
//  MobileChallenge
//
//  Created by Gabriel Vicentin Negro on 20/11/24.
//

import Foundation
import UIKit

class TableViewCurrencyCell: UITableViewCell {
    
    static let identifier = "CurrencyCell"
    
    private let currencyName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private let currencyCode: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        return label
    }()
    
    public func configure(currencyName: String, currencyCode: String) {
        self.currencyName.text = currencyName
        self.currencyCode.text = currencyCode
        loadUI()
    }
    
    private func loadUI() {
        addCurrencyName()
        addCurrencyCode()
    }
    
    private func addCurrencyName() {
        self.contentView.addSubview(currencyName)
        NSLayoutConstraint.activate([
            currencyName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            currencyName.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            currencyName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    private func addCurrencyCode() {
        self.contentView.addSubview(currencyCode)
        NSLayoutConstraint.activate([
            currencyCode.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            currencyCode.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            currencyCode.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
}
