//
//  HomeView.swift
//  CurrencyConverter
//
//  Created by Eduardo Lopes on 29/09/21.
//

import UIKit

final class HomeView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = label.font.withSize(32)
        label.text = "Currency Converter"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var currencyTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        label.text = "From:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var currencyButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("BRL: Brazilian Real", for: .normal)
        btn.contentHorizontalAlignment = .center
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .systemGray5
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    lazy var newCurrencyTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        label.text = "To:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var newCurrencyButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("USD: United States Dollar", for: .normal)
        btn.contentHorizontalAlignment = .center
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .systemGray5
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    lazy var equalTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        label.text = "Is equal to:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var newCurrencyLabel: UILabel = {
        let lbl = UILabel()
        lbl.layer.cornerRadius = 10
        lbl.textAlignment = .center
        lbl.text = "$0,00 USD"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .systemGray5
        return lbl
    }()
    
    lazy var currencyTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "$0,00"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 10
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    init() {
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - View Configurate Moethods
extension HomeView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubViews([titleLabel, currencyTitle, currencyButton, newCurrencyTitle, newCurrencyButton, equalTitle, currencyTextField, newCurrencyLabel])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: topAnchor, constant: 108),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            
            currencyTitle.bottomAnchor.constraint(equalTo: currencyButton.topAnchor, constant: -5),
            currencyTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),

            currencyButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 54),
            currencyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            currencyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            
            newCurrencyTitle.bottomAnchor.constraint(equalTo: newCurrencyButton.topAnchor, constant: -5),
            newCurrencyTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),

            newCurrencyButton.topAnchor.constraint(equalTo: currencyButton.bottomAnchor, constant: 24),
            newCurrencyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            newCurrencyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            
            currencyTextField.topAnchor.constraint(equalTo: newCurrencyButton.bottomAnchor, constant: 54),
            currencyTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            currencyTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            currencyTextField.heightAnchor.constraint(equalTo: currencyButton.heightAnchor),
            
            equalTitle.bottomAnchor.constraint(equalTo: newCurrencyLabel.topAnchor, constant: -5),
            equalTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            
            newCurrencyLabel.topAnchor.constraint(equalTo: currencyTextField.bottomAnchor, constant: 24),
            newCurrencyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            newCurrencyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            newCurrencyLabel.heightAnchor.constraint(equalTo: currencyButton.heightAnchor)
        ])
    }
    
    func configureViews() {
        backgroundColor = .white
    }
    
}
