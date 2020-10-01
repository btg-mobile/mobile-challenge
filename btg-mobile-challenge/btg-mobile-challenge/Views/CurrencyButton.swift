//
//  CurrencyButton.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 01/10/20.
//

import UIKit

final class CurrencyButton: UIButton {

    var currency: String = "" {
        didSet {
            self.setTitle(currency, for: .normal)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        styleButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func styleButton() {
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
        layer.cornerRadius = DesignSpec.Button.cornerRadius
        backgroundColor = .systemRed
        clipsToBounds = true
    }
}
