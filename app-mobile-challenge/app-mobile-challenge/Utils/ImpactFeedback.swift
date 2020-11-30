//
//  ImpactFeedback.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 29/11/20.
//

import UIKit

final class ImpactFeedback {
    /// Gerador de feedback tátil.
    /// - Parameter style: Define a intencidade do impacto.
    static func run(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: style)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
}
