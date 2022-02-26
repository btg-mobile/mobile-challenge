//
//  UITextFieldDefault.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 25/02/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import UIKit

class UITextFieldDefault: UITextField {
    
    // MARK: - Properties
    
    private var currencyCode = { return UILabelDefault() }()
    
    private var spacerRight = { return UIView() }()
    
    // MARK: - Init's
    
    init() {
        super.init(frame: .zero)
        
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        applyViewCode()
    }
    
    // MARK: - Setters
    
    public func setCurrencyCode(_ code: String) {
        self.currencyCode.text = code
    }
    
    public func setPlaceholder(_ placeholder: String) {
        self.placeholder = placeholder
    }
    
}

// MARK: - ViewCodeConfiguration

extension UITextFieldDefault: ViewCodeConfiguration {
    public func configureViews() {
        self.textAlignment      = .right
        self.leftView           = currencyCode
        self.leftViewMode       = .always
        self.rightView          = spacerRight
        self.rightViewMode      = .always
        self.layer.cornerRadius = 10
        
        currencyCode.textAlignment = .center
    }
    
    public func buildHierarchy() {}
    
    public func setupConstraints() {
        
        self.setHeight(55)
        
        spacerRight.setWidth(35)
        
        currencyCode.setWidth(85)
    }
}
