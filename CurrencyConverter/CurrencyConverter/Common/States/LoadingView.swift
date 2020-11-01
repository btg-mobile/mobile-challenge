//
//  LoadingView.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 01/11/20.
//

import UIKit

class LoadingView: UIView {
    
    private lazy var loadingText: UILabel = {
        let label = UILabel().useConstraint()
        label.text = "Loading"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    // MARK: - Life Cycle
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    // MARK: - Setups
    private func setupLayout() {
        backgroundColor = .black
        addSubview(loadingText)
        loadingText
            .top(anchor: topAnchor)
            .leading(anchor: leadingAnchor)
            .trailing(anchor: trailingAnchor)
            .bottom(anchor: bottomAnchor)
    }
}
