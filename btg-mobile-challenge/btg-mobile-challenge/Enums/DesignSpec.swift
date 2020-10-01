//
//  DesignSpec.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 01/10/20.
//

import UIKit

/// The description of the Design Specification.
enum DesignSpec {

    /// The description of each spacing specification.
    enum Spacing {
        static let `default`: CGFloat = 10
        static let medium: CGFloat = 20
        static let large: CGFloat = 30
    }

    /// The description of a Button specification.
    enum Button {
        static let cornerRadius: CGFloat = UIScreen.main.bounds.height * 0.005

        // Constraints
        static let height: CGFloat = 50
        static let widthMultiplier: CGFloat = 0.4
    }

    /// The description of a Label specification.
    enum Label {
        static let height: CGFloat = 30
    }

    /// The description of a TextField specification.
    enum TextField {
        static let height: CGFloat = 50
    }

    /// The description of a Result label specification.
    enum Result {
        static let widthMultiplier: CGFloat = 0.7
        static let height: CGFloat = 50
    }
}
