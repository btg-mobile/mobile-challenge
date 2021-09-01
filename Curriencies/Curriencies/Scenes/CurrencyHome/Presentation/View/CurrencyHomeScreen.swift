//
//  CurrencyHomeScreen.swift
//  Curriencies
//
//  Created by Ferraz on 31/08/21.
//

import UIKit

fileprivate enum Layout {
    static let containerHeight = UIScreen.main.bounds.height/3
    static let textsWidth = UIScreen.main.bounds.width/3 * 2 - 20
    static let itensHeight = containerHeight/2 - 10
    static let buttonsWidth = UIScreen.main.bounds.width/3 - 10
}

final class CurrencyHomeScreen: UIView {
    
    private lazy var originCurrencyButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    private lazy var originCurrencyTextField: UITextField = {
        let textField = UITextField()
        
        return textField
    }()
    
    private lazy var destinationCurrencyButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    private lazy var destinationCurrencyLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CurrencyHomeScreen: ViewConfiguration {
    func buildHierarchy() {
        containerView.addSubviews(views: [
            originCurrencyButton,
            originCurrencyTextField,
            destinationCurrencyLabel,
            destinationCurrencyButton
        ])
        addSubview(containerView)
    }
    
    func makeConstraints() {
        containerView
            .make([.centerX, .centerY, .width], equalTo: self)
            .make(.height, equalTo: Layout.containerHeight)
        
        originCurrencyTextField
            .make(.leading, equalTo: self, constant: -10)
            .make(.top, equalTo: containerView)
            .make(.width, equalTo: Layout.textsWidth)
            .make(.height, equalTo: Layout.itensHeight)
        
        originCurrencyButton
            .make(.leading, equalTo: originCurrencyTextField, attribute: .trailing, constant: -10)
            .make([.top, .height], equalTo: originCurrencyTextField)
            .make(.width, equalTo: Layout.buttonsWidth)
        
        destinationCurrencyLabel
            .make([.leading, .width, .height], equalTo: originCurrencyTextField)
            .make(.bottom, equalTo: containerView)
        
        destinationCurrencyButton
            .make([.leading, .width, .height], equalTo: originCurrencyButton)
            .make(.bottom, equalTo: destinationCurrencyLabel)
    }
}
