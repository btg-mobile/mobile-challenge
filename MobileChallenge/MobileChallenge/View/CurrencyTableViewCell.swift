//
//  CurrencyTableViewCell.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 04/02/25.
//

import Foundation
import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    static let identifier = "CurrencyCell"
    
    let codeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label

    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    func configureCell(name: String, code: String) {
        self.nameLabel.text = name
        self.codeLabel.text = code
        setElements()
    }
    
    func setElements() {
        
        self.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8)
        ])
        
        self.addSubview(codeLabel)
        NSLayoutConstraint.activate([
            codeLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            codeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
    }
}
