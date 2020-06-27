//
//  ConvertAtionButton.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 27/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class ConvertActionButton: UIButton {
    
    private let defaultWidth: CGFloat = 1
    private let defaultText: String = "Apply Convertion"
    private let fontSize: CGFloat = 14
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Could not load button")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.bounds.height / 2
        clipsToBounds = true
    }
    
    private func setup() {
        layer.borderWidth = defaultWidth
        layer.borderColor = UIColor.convertButtonLayerColor.cgColor
        backgroundColor = .convertButtonBackgroundColor
        titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
        setTitle(defaultText, for: .normal)
    }
}
