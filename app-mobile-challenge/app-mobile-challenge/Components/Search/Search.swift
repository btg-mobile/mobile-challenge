//
//  Search.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

final class Search: UISearchBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Pesquise por uma moeda")
    }
    
    private func setup() {
        delegate = self
        layout()
    }
    
    private func layout() {
        barTintColor = .white
        searchTextField.backgroundColor = .white
        tintColor = DesignSystem.Colors.secondary
        placeholder = " Pesquise por uma moeda..."
        layer.borderWidth = 1.5
        layer.borderColor = #colorLiteral(red: 0.9607843137, green: 0.968627451, blue: 0.9803921569, alpha: 1)
        clipsToBounds = true
        backgroundImage = UIImage() //Maior roubo da história...
        isTranslucent = false
        //Rounded
        layer.cornerRadius = 20
    }
}

extension Search: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        debugPrint(textSearched)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
