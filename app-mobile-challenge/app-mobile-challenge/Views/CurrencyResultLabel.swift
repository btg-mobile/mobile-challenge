//
//  CurrencyResultLabel.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

final class CurrencyResultLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Styles the label.
    private func style() {
        textAlignment = .right
        font = TextStyle.display1.font
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.7
        textColor = DesignSystem.Colors.secondary
        text = "1,00"
    }
}
