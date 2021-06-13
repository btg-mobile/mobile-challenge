//
//  Search.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

// Class

final class SearchView: UISearchBar {

    // Lifecycle

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupLayout()
    }
    
    // Private Methods

    private func setupLayout() {
        barTintColor = .white
        searchTextField.backgroundColor = .white
        tintColor = DesignSystem.Colors.secondary
        placeholder = Constants.placeholder
        layer.borderWidth = 1.5
        layer.borderColor = #colorLiteral(red: 0.9607843137, green: 0.968627451, blue: 0.9803921569, alpha: 1)
        clipsToBounds = true
        backgroundImage = UIImage()
        isTranslucent = false
        layer.cornerRadius = 20
    }
}

// Constants

fileprivate extension SearchView {
    enum Constants {
        static let placeholder: String = " Pesquise por uma moeda..."
    }
}
