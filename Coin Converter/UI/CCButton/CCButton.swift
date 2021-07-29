//
//  Button.swift
//  Coin Converter
//
//  Created by Igor Custodio on 27/07/21.
//

import UIKit

enum CCButtonStyleType {
    case link, box, normal
}

class CCButton: UIButton {
    
    private var style: CCButtonStyleType!
    
    required init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(title: String, style: CCButtonStyleType) {
        self.init()
        self.style = style
        setTitle(title, for: .normal)
        setup()
    }
    
    private func setup() {
        switch style! {
            case .link:
                addLinkStyle()
            case .box:
                addBoxStyle()
            case .normal:
                break
        }
        
    }
    
    private func addBoxStyle() {
        addShadow()
        backgroundColor = .white
        setTitleColor(.black, for: .normal)
    }
    
    private func addLinkStyle() {
        titleLabel?.textColor = UIColor(hex: "#364DF8")
        backgroundColor = .clear
        titleLabel?.font = titleLabel?.font.withSize(12)
        setTitleColor(UIColor(hex: "#364DF8"), for: .normal)
        
        guard let text = currentTitle else { return }
        let textRange = NSRange(location: 0, length: text.count)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.underlineStyle,
                                    value: NSUnderlineStyle.single.rawValue,
                                    range: textRange)
        
        titleLabel?.attributedText = attributedText
    }
}
