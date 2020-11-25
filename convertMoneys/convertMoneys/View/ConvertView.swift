//
//  ConvertView.swift
//  convertMoneys
//
//  Created by Mateus Rodrigues Santos on 25/11/20.
//

import UIKit

class ConvertView: UIView {
    
    let titleLabel:UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.text = "Conversão"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = UIColor(named: "colorText")
        label.layer.zPosition = 3
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabelOrigin:UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.text = "Moeda de Origem"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor(named: "colorText")
        label.layer.zPosition = 3
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabelDestiny:UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.text = "Moeda de destino"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor(named: "colorText")
        label.layer.zPosition = 3
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Button for onboard mode
    let changeButtonOrigin: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Trocar Moeda", for: .normal)
        button.backgroundColor = .white
        button.layer.zPosition = 3
        button.layer.cornerRadius = 5
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    /// Button for onboard mode
    let destinyButtonOrigin: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Trocar Moeda", for: .normal)
        button.backgroundColor = .white
        button.layer.zPosition = 3
        button.layer.cornerRadius = 5
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    /// Button for onboard mode
    let textInputOrigin: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "Digite o Valor"
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    /// Button for onboard mode
    let textInputDestiny: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "Digite o Valor"
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let currencyOrigin:UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.text = "R$"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = UIColor(named: "colorText")
        label.layer.zPosition = 3
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let currencyDestiny:UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.text = "USD$"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = UIColor(named: "colorText")
        label.layer.zPosition = 3
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Button for onboard mode
    let convertButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Converter", for: .normal)
        button.backgroundColor = .white
        button.layer.zPosition = 3
        button.layer.cornerRadius = 5
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ConvertView:ViewCodable{
    func setupViewHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(titleLabelOrigin)
        self.addSubview(titleLabelDestiny)
        self.addSubview(changeButtonOrigin)
        self.addSubview(destinyButtonOrigin)
        self.addSubview(textInputOrigin)
        self.addSubview(textInputDestiny)
        self.addSubview(currencyOrigin)
        self.addSubview(currencyDestiny)
        self.addSubview(convertButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            titleLabelOrigin.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 140),
            titleLabelOrigin.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 40),
        ])
        
        NSLayoutConstraint.activate([
            titleLabelDestiny.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -300),
            titleLabelDestiny.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 40),
        ])
        
        NSLayoutConstraint.activate([
            changeButtonOrigin.widthAnchor.constraint(equalToConstant: 110),
            changeButtonOrigin.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 140),
            changeButtonOrigin.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            destinyButtonOrigin.widthAnchor.constraint(equalToConstant: 110),
            destinyButtonOrigin.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -300),
            destinyButtonOrigin.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            textInputOrigin.heightAnchor.constraint(equalToConstant: 50),
            textInputOrigin.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.4),
            textInputOrigin.topAnchor.constraint(equalTo: titleLabelOrigin.bottomAnchor, constant: 50),
            textInputOrigin.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 40),
        ])
        
        NSLayoutConstraint.activate([
            textInputDestiny.heightAnchor.constraint(equalToConstant: 50),
            textInputDestiny.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.4),
            textInputDestiny.topAnchor.constraint(equalTo: titleLabelDestiny.bottomAnchor, constant: 50),
            textInputDestiny.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 40),
        ])
        
        NSLayoutConstraint.activate([
            currencyOrigin.topAnchor.constraint(equalTo:  changeButtonOrigin.bottomAnchor, constant: 40),
            
            currencyOrigin.leadingAnchor.constraint(equalTo: textInputOrigin.trailingAnchor,constant: 30),
        ])
        
        NSLayoutConstraint.activate([
            currencyDestiny.topAnchor.constraint(equalTo:  destinyButtonOrigin.bottomAnchor, constant: 50),
            
            currencyDestiny.leadingAnchor.constraint(equalTo: textInputDestiny.trailingAnchor,constant: 30),
        ])
        
        NSLayoutConstraint.activate([
            convertButton.widthAnchor.constraint(equalToConstant: 100),
            convertButton.heightAnchor.constraint(equalToConstant: 40),
            convertButton.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -100),
            convertButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])

    }
    
    func setupAditionalConfiguration() {
        self.backgroundColor = .clear
    }
}
