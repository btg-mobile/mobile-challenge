//
//  CurrencyConvertionView.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 27/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class CurrencyConvertionView: UIView {
    
    private unowned var firstCurrencyButton: CurrencyButton
    private unowned var secondCurrencyButton: CurrencyButton
    private unowned var convertActionButton: ConvertActionButton
    private unowned var resultLbl: UILabel
    
    private lazy var firstCurrencyLbl: UILabel = {
        return UILabel(frame: .zero)
    }()
    
    private lazy var secondCurrencyLbl: UILabel = {
        return UILabel(frame: .zero)
    }()
    
    private lazy var currencyTextField: UITextField = {
        return UITextField(frame: .zero)
    }()
    
    private lazy var imageView: UIImageView = {
        return UIImageView(frame: .zero)
    }()
    
    init(frame: CGRect = .zero,
         firstCurrencyButton: CurrencyButton,
         secondCurrencyButton: CurrencyButton,
         convertActionButton: ConvertActionButton,
         resultLbl: UILabel) {
        self.firstCurrencyButton = firstCurrencyButton
        self.secondCurrencyButton = secondCurrencyButton
        self.convertActionButton = convertActionButton
        self.resultLbl = resultLbl
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension CurrencyConvertionView: ViewCodeProtocol {
     
    func buildHierarchy() {
        addSubview(firstCurrencyButton)
        addSubview(firstCurrencyLbl)
        addSubview(secondCurrencyLbl)
        addSubview(secondCurrencyButton)
        addSubview(currencyTextField)
        addSubview(convertActionButton)
        addSubview(imageView)
        addSubview(resultLbl)
    }
    
    func setupConstraints() {
        firstCurrencyLbl.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint(item: firstCurrencyLbl, attribute: .top, relatedBy: .equal, toItem: topAnchor, attribute: .top, multiplier: 1.0, constant: <#T##CGFloat#>)
    }
    
    func configureViews() {
        
    }
}
