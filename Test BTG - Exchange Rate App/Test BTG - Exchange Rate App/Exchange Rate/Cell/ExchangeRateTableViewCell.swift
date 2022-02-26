//
//  ExchangeRateTableViewCell.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 25/02/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import UIKit

class ExchangeRateTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "ExchangeRateTableViewCell"
    
    private let currencyCode: UILabel = {
        let label = UILabelDefault()
        label.text  = "-"
        return label
    }()
    
    private let currencyRate: UILabel = {
        let label = UILabelDefault()
        
        label.text          = "0.00"
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
        currencyCode.text = code
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        configureViews()
        buildHierarchy()
    }
    
    private func configureViews() {
        self.accessoryType = .disclosureIndicator
    }
    
    private func buildHierarchy() {
        self.contentView.addSubview(currencyCode)
        self.contentView.addSubview(currencyRate)
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
        
        currencyRate.anchor(
            top: contentView.topAnchor,
            bottom: contentView.bottomAnchor,
            right: contentView.rightAnchor,
            paddingRight: 20,
            width: contentView.frame.size.width / 2
        )
    }

}
