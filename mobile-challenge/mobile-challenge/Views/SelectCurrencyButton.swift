//
//  SelectCurrencyButton.swift
//  mobile-challenge
//
//  Created by gabriel on 02/12/20.
//

import UIKit

class SelectCurrencyButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    func setupUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel?.font = .systemFont(ofSize: 16, weight: .heavy)
        self.backgroundColor = .systemGray6
        self.setTitleColor(.systemGray, for: .normal)
        self.layer.cornerRadius = 10
    }
    
    func setupConstraints() {
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
