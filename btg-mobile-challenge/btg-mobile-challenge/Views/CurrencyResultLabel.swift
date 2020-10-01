//
//  CurrencyResultLabel.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 01/10/20.
//

import UIKit

final class CurrencyResultLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        styleLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func styleLabel() {
        textAlignment = .center
        font = .preferredFont(forTextStyle: .largeTitle)
    }
}
