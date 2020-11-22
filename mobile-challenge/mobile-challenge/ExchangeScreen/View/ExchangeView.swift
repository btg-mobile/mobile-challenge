//
//  ExchangeView.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation
import UIKit

class ExchangeView: UIView {
    
    var exchangeStackView: UIStackView {
        let stackView = UIStackView()
        return stackView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ExchangeView: ViewCodable {
    func setupConstraints() {
        
    }
    
    func setupViewHierarchy() {
        
    }
}
