//
//  CurrencyStackView.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation
import UIKit

class CurrencyStackView: UIStackView {
    
    var valueTextField: UITextField {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        return textField
    }
    
    var currencyButton: UIButton {
        let button = UIButton()
        button.setTitle("Escolha a moeda", for: .normal)
        return button
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axis = .horizontal
        distribution = .fill
        spacing = 50
        alignment = .center
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CurrencyStackView: ViewCodable {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            valueTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            valueTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
            valueTextField.topAnchor.constraint(equalTo: topAnchor),
            
            currencyButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            currencyButton.topAnchor.constraint(equalTo: topAnchor),
            currencyButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupViewHierarchy() {
        addArrangedSubview(valueTextField)
        addArrangedSubview(currencyButton)
    }
}
