//
//  CalculationButton.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

final class CalculationButton: UIButton {
    
    // - MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        titleLabel?.font = TextStyle.display3.font
        setTitleColor(.white, for: .normal)
        setTitle("Calcular", for: .normal)
        let icon = DesignSystem.Backgrounds.gradientButton
        backgroundImage(for: .normal)
        clipsToBounds = false
        layer.cornerRadius = 24
        setBackgroundImage(icon, for: .normal)
        clipsToBounds = true
    }
}
