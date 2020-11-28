//
//  CurrencyButtonView.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

final class BackButtonView: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func style() {
        let icon = DesignSystem.Icons.back
        setImage(icon, for: .normal)
        imageView?.contentMode = .scaleAspectFit
        clipsToBounds = true
    }
}
