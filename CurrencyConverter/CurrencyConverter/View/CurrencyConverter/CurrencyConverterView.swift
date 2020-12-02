//
//  CurrencyConverterView.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 01/12/20.
//

import UIKit

class CurrencyConverterView: UIView {
    // MARK: - Views
    
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - ViewCodable
extension CurrencyConverterView: ViewCodable {
    func setupHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func setupAditionalConfiguration() {
        self.backgroundColor = .systemBackground
    }
}
