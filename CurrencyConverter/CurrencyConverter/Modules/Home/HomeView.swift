//
//  HomeView.swift
//  CurrencyConverter
//
//  Created by Eduardo Lopes on 29/09/21.
//

import UIKit

final class HomeView: UIView {
    
    lazy var contentView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.spacing = 8
        view.alignment = .fill
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var currencyButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("De", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .yellow
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    lazy var newCurrencyButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Para", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .black
        return btn
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
        addSubViews([currencyButton, newCurrencyButton])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            currencyButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            currencyButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            currencyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            currencyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            
            newCurrencyButton.topAnchor.constraint(equalTo: currencyButton.bottomAnchor),
            newCurrencyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            newCurrencyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)
        ])
    }
    
    func configureViews() {
        backgroundColor = .white
    }
    
}
