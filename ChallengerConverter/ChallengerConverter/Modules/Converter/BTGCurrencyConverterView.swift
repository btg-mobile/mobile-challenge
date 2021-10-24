//
//  BTGCurrencyConverterView.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 21/10/21.
//


import UIKit


class BTGCurrencyConverterView: UIView {
    
    
    var buttonFrom: BorderedButton = {
        let btn = BorderedButton()
        btn.setTitle("BRL: Brazilian Real", for: .normal)
        btn.contentHorizontalAlignment = .center
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    var buttonTo: BorderedButton = {
        let btn = BorderedButton()
        btn.setTitle("BRL: Brazilian Real", for: .normal)
        btn.contentHorizontalAlignment = .center
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    var currencyTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.textAlignment = .center
        textField.text = "0.00"
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.keyboardType = .numberPad
        return textField
    }()
    var currencyConverterLabel: UILabel  = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = lbl.font.withSize(32)
        lbl.text = "Currency Converter"
        lbl.textColor = .black
        return lbl
    }()
    

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupUI()
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


fileprivate extension BTGCurrencyConverterView {
    func setupUI() {
        self.backgroundColor = .white
    }
    
    func addViews() {
        self.addSubViews(views: [
            buttonFrom,
            buttonTo,
            currencyTextField,
            currencyConverterLabel
        ])
        
    }
    
    func addConstraints() {
        let layoutGuides = layoutMarginsGuide
        
        NSLayoutConstraint.activate([
        
            buttonFrom.topAnchor.constraint(equalTo: layoutGuides.topAnchor),
            buttonFrom.trailingAnchor.constraint(equalTo: layoutGuides.trailingAnchor),
            buttonFrom.leadingAnchor.constraint(equalTo: layoutGuides.leadingAnchor),
            buttonFrom.heightAnchor.constraint(equalToConstant: 45),
        
            buttonTo.topAnchor.constraint(equalTo: buttonFrom.bottomAnchor, constant: 10),
            buttonTo.trailingAnchor.constraint(equalTo: layoutGuides.trailingAnchor),
            buttonTo.leadingAnchor.constraint(equalTo: layoutGuides.leadingAnchor),
            buttonTo.heightAnchor.constraint(equalToConstant: 45),
            
            currencyTextField.topAnchor.constraint(equalTo: buttonTo.bottomAnchor, constant: 10),
            currencyTextField.trailingAnchor.constraint(equalTo: layoutGuides.trailingAnchor),
            currencyTextField.leadingAnchor.constraint(equalTo: layoutGuides.leadingAnchor),
            currencyTextField.heightAnchor.constraint(equalToConstant: 45),
            
            currencyConverterLabel.topAnchor.constraint(equalTo: currencyTextField.bottomAnchor, constant: 10),
            currencyConverterLabel.trailingAnchor.constraint(equalTo: layoutGuides.trailingAnchor),
            currencyConverterLabel.leadingAnchor.constraint(equalTo: layoutGuides.leadingAnchor),
            currencyConverterLabel.heightAnchor.constraint(equalToConstant: 45)
        ])
        
    }
    
}
