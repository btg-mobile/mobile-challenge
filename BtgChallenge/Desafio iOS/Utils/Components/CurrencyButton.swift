//
//  CurrencyButton.swift
//  Desafio iOS
//
//  Created by Lucas Soares on 29/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import Foundation
import UIKit

protocol CurrencyButtonDelegate: class {
    func tapCoinButton(view: CurrencyButton)
}

class CurrencyButton: UIView {
    
    
    // MARK: - Properties
    
    var coinLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.text = "BRL"
        return label
    }()
    
    var arrowDownImageView: UIImageView = {
        return UIImageView()
    }()
    
    weak var delegate: CurrencyButtonDelegate?
    
    // MARK: - Lyfe Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    init() {
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    
    private func setup() {
        setupConstraints()
        setupTapRecognizer()
        setupView()
    }
    
    func setupTapRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTap() {
        delegate?.tapCoinButton(view: self)
    }
    
    private func setupConstraints() {
        addSubview(coinLabel)
        addSubview(arrowDownImageView)
        
        coinLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowDownImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowDownImageView.image = UIImage(named: "arrow_down_white")
        
        coinLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        coinLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
        
        arrowDownImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        arrowDownImageView.leadingAnchor.constraint(equalTo: self.coinLabel.trailingAnchor, constant: 32).isActive = true
        
    }
    
    private func setupView() {
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.backgroundColor = .clear
    }
    
}
