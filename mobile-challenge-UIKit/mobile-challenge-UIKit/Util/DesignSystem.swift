//
//  DesignSystem.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 17/12/20.
//

import UIKit

struct DesignSystem {

    struct Spacing {
        static let `default`: CGFloat = 10
    }

    struct Colors {
        static let background: UIColor = .systemBackground
        static let border: UIColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        static let currencyCode: UIColor = #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
        static let primaryText: UIColor = .label
        static let secondaryText: UIColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.6)
        static let action: UIColor = #colorLiteral(red: 0.09803921569, green: 0.3529411765, blue: 0.7058823529, alpha: 1)
    }

    struct TextField {
        static let height: CGFloat = 68
        static let width: CGFloat = UIScreen.main.bounds.width
        static let cornerRadius: CGFloat = min(height, width) / 2
        static let borderWidth: CGFloat = 1
    }

    struct InputAccessoryView {
        static let x: CGFloat = .zero
        static let y: CGFloat = .zero
        static let width: CGFloat = UIScreen.main.bounds.width
        static let height: CGFloat = 40
        static let frame: CGRect = CGRect(x: x, y: y, width: width, height: height)
    }

    struct InputAccessoryViewButton {
        static let x: CGFloat = UIScreen.main.bounds.width - width
        static let y: CGFloat = .zero
        static let width: CGFloat = 80
        static let height: CGFloat = InputAccessoryView.height
        static let frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
}
