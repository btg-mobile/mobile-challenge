//
//  CurrencyStackView.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation
import UIKit

class CurrencyStackView: UIStackView {
    
    var buttonType: ButtonType?
    
    var valueTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        textField.text = "0.00"
        textField.borderStyle = .roundedRect
        textField.textAlignment = .right
        return textField
    }()
    
    var currencyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Escolha a moeda", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(showCurrencyScreen), for: .touchUpInside)
        return button
    }()
    
    var selectCurrency: ((ButtonType?) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        axis = .horizontal
        distribution = .fillProportionally
        alignment = .center
        spacing = 10
        translatesAutoresizingMaskIntoConstraints = false
       
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func showCurrencyScreen() {
        selectCurrency?(buttonType)
    }
}

extension CurrencyStackView: ViewCodable {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            valueTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            valueTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
            valueTextField.topAnchor.constraint(equalTo: topAnchor),
            
            currencyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            currencyButton.topAnchor.constraint(equalTo: topAnchor),
            currencyButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupViewHierarchy() {
        addArrangedSubview(valueTextField)
        addArrangedSubview(currencyButton)
    }
}
