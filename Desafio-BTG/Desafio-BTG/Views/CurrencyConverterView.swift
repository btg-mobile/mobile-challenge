//
//  CurrencyConverterView.swift
//  Desafio-BTG
//
//  Created by Euclides Medeiros on 31/03/21.
//

import UIKit

class CurrencyConverterView: UIView {
    
    // MARK: - Properties
    
    /// clousure to trigger function in viewController
    var firstCountyAction: (() -> Void)?
    var secondCountryAction: (() -> Void)?
    
    // MARK: - Constants
    
    private let viewModel: RealTimeRatesViewModel
    
    /// creating stack view main
    var mainStackView: UIStackView = UIStackView()
    
    /// creating stacks
    var stackView: UIStackView = UIStackView()
    var stackViewRight: UIStackView = UIStackView()
    var stackViewLeft: UIStackView = UIStackView()
    
    /// creating UIView
    var contentView: UIView = UIView()
    
    let insertTextField: UITextField = {
        let tf = UITextField("insira um valor a ser convertido")
        return tf
    }()
    
    let valueConverttedTextField: UITextField = {
        let tf = UITextField("valor convertido")
        return tf
    }()
    
    let convertCurrencies: UIButton = {
        let button = UIButton(title: "Converter moedas", borderColor: UIColor.blue)
        button.addTarget(self, action: #selector(handleConvert), for: .touchUpInside)
        return button
    }()
    
    var labelFirst: UILabel = {
        let label = UILabel()
        label.text = "De:"
        return label
    }()
    
    let currentCurrency: UIButton = {
        let button = UIButton(title: "USA", borderColor: UIColor.blue)
        button.addTarget(self, action: #selector(handlefirstCountry), for: .touchUpInside)
        return button
    }()
    
    let currencyDestinationLabel: UILabel = {
        let label = UILabel()
        label.text = "Para:"
        return label
    }()
    
    let destinationCountryBt: UIButton = {
        let button = UIButton(title: "BRL", borderColor: UIColor.blue)
        button.addTarget(self, action: #selector(handleSecondCountry), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Override & Initializers
    
    init(viewModel: RealTimeRatesViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        autoLayoutMainStackView()
        autoLayoutStacks()
        autoLayoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    
    private func configureViews() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    func autoLayoutMainStackView() {
        self.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        mainStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.distribution = .fill
        mainStackView.spacing = 10
    }
    
    func autoLayoutStacks() {
        mainStackView.addArrangedSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackViewRight.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(stackViewRight)
        stackViewRight.axis = .vertical
        stackViewRight.alignment = .leading
        stackViewRight.distribution = .fillEqually
        stackViewRight.spacing = 0
        
        stackViewRight.addArrangedSubview(labelFirst)
        labelFirst.translatesAutoresizingMaskIntoConstraints = false
        
        stackViewRight.addArrangedSubview(currentCurrency)
        
        currentCurrency.widthAnchor.constraint(equalToConstant: 100).isActive = true
        currentCurrency.translatesAutoresizingMaskIntoConstraints = false
        
        stackViewLeft.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(stackViewLeft)
        stackViewLeft.axis = .vertical
        stackViewLeft.alignment = .trailing
        stackViewLeft.distribution = .fillEqually
        stackViewLeft.spacing = 0
        
        currencyDestinationLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        currencyDestinationLabel.translatesAutoresizingMaskIntoConstraints = false
        stackViewLeft.addArrangedSubview(currencyDestinationLabel)
        
        destinationCountryBt.widthAnchor.constraint(equalToConstant: 100).isActive = true
        destinationCountryBt.translatesAutoresizingMaskIntoConstraints = false
        stackViewLeft.addArrangedSubview(destinationCountryBt)
    }
    
    func autoLayoutView() {
        mainStackView.addArrangedSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(insertTextField)
        contentView.addSubview(valueConverttedTextField)
        contentView.addSubview(convertCurrencies)
        
        insertTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24).isActive = true
        insertTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        insertTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        insertTextField.heightAnchor.constraint(equalToConstant: 28).isActive = true
        insertTextField.translatesAutoresizingMaskIntoConstraints = false
        
        valueConverttedTextField.topAnchor.constraint(equalTo: insertTextField.bottomAnchor, constant: 24).isActive = true
        valueConverttedTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        valueConverttedTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        valueConverttedTextField.heightAnchor.constraint(equalToConstant: 28).isActive = true
        valueConverttedTextField.translatesAutoresizingMaskIntoConstraints = false
        
        convertCurrencies.topAnchor.constraint(equalTo: valueConverttedTextField.bottomAnchor, constant: 24).isActive = true
        convertCurrencies.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        convertCurrencies.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        convertCurrencies.heightAnchor.constraint(equalToConstant: 48).isActive = true
        convertCurrencies.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Public Functions
    
    /// functions to trigger login and signIn
    @objc func handlefirstCountry() {
        firstCountyAction?()
    }

    @objc func handleSecondCountry() {
        secondCountryAction?()
        print("clicou no segundo pais")
    }
    
    @objc func handleConvert() {
        print("convertendo moedas")
    }
}
