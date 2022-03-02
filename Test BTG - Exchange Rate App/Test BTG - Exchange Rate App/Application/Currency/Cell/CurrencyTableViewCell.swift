//
//  CurrencyTableViewCell.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 25/02/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "CurrencyTableViewCell"
    
    private let currencyCode: UILabel = {
        let label = UILabelDefault()
        return label
    }()
    
    private let currencyName: UILabel = {
        let label = UILabelDefault()
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    // MARK: - Setters
    
    public func setCurrencyCode(_ code: String) {
        self.currencyCode.text = code
    }
    
    public func setCurrencyName(_ name: String) {
        self.currencyName.text = name
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        configureViews()
        buildHierarchy()
    }
    
    private func configureViews() {
    }
    
    private func buildHierarchy() {
        self.contentView.addSubview(currencyCode)
        self.contentView.addSubview(currencyName)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        currencyCode.anchor(
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            bottom: contentView.bottomAnchor,
            paddingLeft: 35,
            width: contentView.frame.size.width / 2
        )
        
        currencyName.anchor(
            top: contentView.topAnchor,
            bottom: contentView.bottomAnchor,
            right: contentView.rightAnchor,
            paddingRight: 20,
            width: contentView.frame.size.width / 2
        )
    }

}
