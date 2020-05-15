//
//  BTGConverterResultCardItem.swift
//  BTGConverterAPP
//
//  Created by Ana Caroline de Souza on 15/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import UIKit

class BTGConverterResultCardItem: UIView {
    
    
    let userInputValueTitleLabel = BTGTitleLabel(textAlignment: .left, fontSize: 24)
    let currencyTextField = BTGTextField(frame: .zero)
    let convertResultLabel = BTGSecondaryTitleLabel(fontSize: 24)
    let convertButton = BTGButton(backgroundColor: .brown, title: "=")
    
    let verticalPadding : CGFloat = 10
    let horizontalPadding : CGFloat = 10
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        
        configureValueTitleLabel()
        configureConvertButton()
        configureValueTextField()
        configureConvertResultLabel()
    }

    private func configureValueTitleLabel() {
        addSubview(userInputValueTitleLabel)
        userInputValueTitleLabel.backgroundColor = .blue
        userInputValueTitleLabel.text = "Valor"
        
        NSLayoutConstraint.activate([
            userInputValueTitleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            userInputValueTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: horizontalPadding),
            userInputValueTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.20),
            userInputValueTitleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45)
        
        ])
    }
    
    private func configureConvertButton() {
        addSubview(convertButton)
        
        convertButton.backgroundColor = .systemBackground
        convertButton.titleLabel?.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        
        NSLayoutConstraint.activate([
            convertButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -horizontalPadding),
            convertButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.39),
            convertButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.39),
            convertButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        
        ])
    }
    
    private func configureValueTextField() {
        addSubview(currencyTextField)
        
        NSLayoutConstraint.activate([
            currencyTextField.topAnchor.constraint(equalTo: self.topAnchor),
            currencyTextField.leadingAnchor.constraint(equalTo: userInputValueTitleLabel.trailingAnchor, constant: horizontalPadding),
            currencyTextField.trailingAnchor.constraint(equalTo: convertButton.leadingAnchor, constant: -horizontalPadding),
            currencyTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45)
        
        ])
    }
    
    private func configureConvertResultLabel() {
        addSubview(convertResultLabel)
        convertResultLabel.backgroundColor = .systemRed
        convertResultLabel.text = "Resultado: 234234234 USD"
        
        NSLayoutConstraint.activate([
            convertResultLabel.topAnchor.constraint(equalTo: userInputValueTitleLabel.bottomAnchor, constant: verticalPadding),
            convertResultLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: horizontalPadding),
            convertResultLabel.trailingAnchor.constraint(equalTo: convertButton.leadingAnchor),
            convertResultLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalPadding)
        
        ])
    }
    
}
