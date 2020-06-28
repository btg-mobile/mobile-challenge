//
//  CurrencyButton.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 24/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class CurrencyButton: UIButton {
    
    private let defaultWidth: CGFloat = 1
    
    private var title: String {
        didSet {
            setTitle(title, for: .normal)
        }
    }
    
    init(frame: CGRect = .zero, title: String = .empty) {
        self.title = title
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        self.title = .empty
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.bounds.height / 2
        clipsToBounds = true
    }
    
    private func setup() {
        layer.borderColor = UIColor.currencyButtonLayerColor.cgColor
        layer.borderWidth = defaultWidth
        backgroundColor = UIColor.currencyButtonBackgroundColor
        titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
    }
}