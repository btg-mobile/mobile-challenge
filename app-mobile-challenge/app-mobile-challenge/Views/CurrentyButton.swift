//
//  SupportedButton.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit


final class CurrentyButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func style() {
        titleLabel?.font = TextStyle.display1.font
        setTitleColor(DesignSystem.Colors.primary, for: .normal)
        setTitle("USD", for: .normal)
        clipsToBounds = true
    }
}
