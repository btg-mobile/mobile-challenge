//
//  TitleLabel.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

final class TitleLabel: UILabel {
    
    // - MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// Configuração de aparencia da label.
    private func style() {
        textAlignment = .center
        font = TextStyle.display2.font
        textColor = DesignSystem.Colors.secondary
    }
}
