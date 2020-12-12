//
//  BaseView.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 12/12/20.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    required public init() {
        super.init(frame: CGRect.zero)
        self.setup()
    }
    
    func initialize() {}
    
    func addViews() {}
    
    func autoLayout() {}
    
    override func didMoveToSuperview() {
        autoLayout()
    }
    
    private func setup() {
        self.initialize()
        self.addViews()
    }
    
}
