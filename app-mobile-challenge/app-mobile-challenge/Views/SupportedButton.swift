//
//  SupportedButton.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 27/11/20.
//

import UIKit


final class SupportedButton: UIButton {

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
        setTitleColor(DesignSystem.Colors.primary, for: .normal) 
        setTitle("moedas", for: .normal)
        let icon = DesignSystem.Icons.coins
        setImage(icon, for: .normal)
        imageView?.contentMode = .scaleAspectFit
//      configura a imagem para estar ao lado do texto
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        clipsToBounds = true
    }
}
