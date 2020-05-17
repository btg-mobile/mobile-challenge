//
//  BTGConverterTitleCard.swift
//  BTGConverterAPP
//
//  Created by Leonardo Maia Pugliese on 16/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import UIKit

class BTGConverterTitleCard: UIView {
    
    var titleLabel = BTGTitleLabel(textAlignment: .left, fontSize: 33)
    var lastTimeUpdatedLabel = BTGSecondaryTitleLabel(frame: .zero)
    let verticalPadding : CGFloat = 10
    let horizontalPadding : CGFloat = 10
    var lastUpdated : String = ""
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        configureTitleLabel()
        configureLastUpdatedLabel()
    }
    
    func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.text = ViewsConstants.BTGConverterTitleCardTitle.rawValue
        backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: horizontalPadding),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -horizontalPadding),
            titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5)
        ])
    }
    
    func configureLastUpdatedLabel() {
        
        addSubview(lastTimeUpdatedLabel)
        lastTimeUpdatedLabel.text =
            ViewsConstants.BTGConverterTitleCardDefaultLastTimeUpdateMessage.rawValue + lastUpdated
        lastTimeUpdatedLabel.backgroundColor = .systemBackground
        lastTimeUpdatedLabel.textColor = .systemGreen
        
        NSLayoutConstraint.activate([
            lastTimeUpdatedLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -2),
            lastTimeUpdatedLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: horizontalPadding),
            lastTimeUpdatedLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -horizontalPadding),
            lastTimeUpdatedLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45)
            
        ])
        
    }
    
}
