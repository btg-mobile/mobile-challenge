//
//  QuotationView.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 25/11/20.
//

import UIKit

enum TagButton: Int {
    case quotation = 0
    case currency = 1
}

class QuotationView: UIView {
    
    var quotationButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.setTitle("Quotation", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.tag = TagButton.quotation.rawValue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var currencyButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.setTitle("Currency", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.tag = TagButton.currency.rawValue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var label: UILabel = {
        var label = UILabel(frame: .zero)
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QuotationView: ViewCodable {
    func setupHierarchy() {
        addSubview(quotationButton)
        addSubview(currencyButton)
        addSubview(label)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            quotationButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -30),
            quotationButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            currencyButton.topAnchor.constraint(equalTo: quotationButton.bottomAnchor, constant: 20),
            currencyButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            label.topAnchor.constraint(equalTo: currencyButton.bottomAnchor, constant: 30),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
    }
    
    func setupAditionalConfiguration() {
        backgroundColor = .white
    }
}
