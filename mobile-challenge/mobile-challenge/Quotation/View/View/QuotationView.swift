//
//  QuotationView.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 25/11/20.
//

import UIKit

class QuotationView: UIView {
    
    var requestButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.setTitle("Request", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var label: UILabel = {
        var label = UILabel(frame: .zero)
        label.textColor = .systemGray4
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
        addSubview(requestButton)
        addSubview(label)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            requestButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            requestButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            label.topAnchor.constraint(equalTo: requestButton.bottomAnchor, constant: 30),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 30)
        ])
    }
    
    func setupAditionalConfiguration() {
        backgroundColor = .white
    }
}
