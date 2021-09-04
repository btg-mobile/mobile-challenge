//
//  CoinTableHeader.swift
//  CoinExchanger
//
//  Created by Junior on 03/09/21.
//

import UIKit

class CoinTableHeader: UIView {
    weak var visualDelegate: VisualInputDelegate? {
        didSet { searchField.visualDelegate = visualDelegate }}
    
    // MARK: View
    let searchField: VisualInputSearch = {
        let field = VisualInputSearch()
        field.accessibilityHint = L10n.Coin.List.searchHint
        field.attributedPlaceholder = NSAttributedString(string: L10n.Coin.List.search, attributes: [ NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        field.kind = .none
        field.tag = 1
        return field
    }()
    
    // MARK: Override
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
}

private extension CoinTableHeader {
    // MARK: Setup
    func setup() {
        backgroundColor = .white
        
        addSubview(searchField)
        searchField.fill(to: self, constant: Constants.space)
        searchField.height(constant: 56)
    }
}
