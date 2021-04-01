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
    
    var mainStackView: UIStackView = UIStackView()
    
    var stackView1: UIStackView = UIStackView()
    var stackView11: UIStackView = UIStackView()
    var stackView12: UIStackView = UIStackView()
    var contentView: UIView = UIView()
    var txtViewDescription: UITextView = UITextView()
    /// creating stack view main
    
    var ofLabel: UILabel  = {
        let label = UILabel()
        label.text = "de:"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var toLabel: UILabel  = {
        let label = UILabel()
        label.text = "para:"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let valueToBeConverted: UITextField = {
        let tf = UITextField("1")
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let convertedValue: UITextField = {
        let tf = UITextField("1")
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let selectCountryOne: UIButton = {
        let button = UIButton(title: "BRL", borderColor: UIColor.systemBlue)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let selectCountryTwo: UIButton = {
        let button = UIButton(title: "USD", borderColor: UIColor.systemBlue)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Override & Initializers
    
    init(viewModel: RealTimeRatesViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
//        setupStack()
//        setupViewHierarchy()
        autoLayoutMainStackView()
        autoLayoutStackView1()
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
    
    private func setupViewHierarchy() {
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
    
    func autoLayoutStackView1() {
        mainStackView.addArrangedSubview(stackView1)
        stackView1.translatesAutoresizingMaskIntoConstraints = false
        
        stackView11.translatesAutoresizingMaskIntoConstraints = false
        stackView1.addArrangedSubview(stackView11)
        stackView11.axis = .vertical
        stackView11.alignment = .leading
        stackView11.distribution = .fillEqually
        stackView11.spacing = 0
        
        let labelFirst = UILabel()
        labelFirst.translatesAutoresizingMaskIntoConstraints = false
        labelFirst.text = "De:"
        stackView11.addArrangedSubview(labelFirst)
        
        let currentCurrency: UIButton = {
            let button = UIButton(title: "USA", borderColor: UIColor.blue)
            button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
            return button
        }()
        
        stackView11.addArrangedSubview(currentCurrency)
        
        currentCurrency.widthAnchor.constraint(equalToConstant: 100).isActive = true
        currentCurrency.translatesAutoresizingMaskIntoConstraints = false
        
        stackView12.translatesAutoresizingMaskIntoConstraints = false
        stackView1.addArrangedSubview(stackView12)
        stackView12.axis = .vertical
        stackView12.alignment = .trailing
        stackView12.distribution = .fillEqually
        stackView12.spacing = 0
        
        
        let currencyDestinationLabel = UILabel()
        currencyDestinationLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyDestinationLabel.text = "Para:"
        stackView12.addArrangedSubview(currencyDestinationLabel)
        currencyDestinationLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        let destinationCountryBt: UIButton = {
            let button = UIButton(title: "BRL", borderColor: UIColor.blue)
            button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
            return button
        }()
        
        destinationCountryBt.widthAnchor.constraint(equalToConstant: 100).isActive = true
        destinationCountryBt.translatesAutoresizingMaskIntoConstraints = false
        
        stackView12.addArrangedSubview(destinationCountryBt)
    }
    
    func autoLayoutView() {
        
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
    
        insertTextField.translatesAutoresizingMaskIntoConstraints = false
        valueConverttedTextField.translatesAutoresizingMaskIntoConstraints = false
        convertCurrencies.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(insertTextField)
        contentView.addSubview(valueConverttedTextField)
        contentView.addSubview(convertCurrencies)
        
        
        mainStackView.addArrangedSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        insertTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24).isActive = true
        insertTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        insertTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        insertTextField.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        valueConverttedTextField.topAnchor.constraint(equalTo: insertTextField.bottomAnchor, constant: 24).isActive = true
        valueConverttedTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        valueConverttedTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        valueConverttedTextField.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        convertCurrencies.topAnchor.constraint(equalTo: valueConverttedTextField.bottomAnchor, constant: 24).isActive = true
        convertCurrencies.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        convertCurrencies.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        convertCurrencies.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
                
    }
    
    // MARK: - Public Functions
    
    /// functions to trigger login and signIn
    @objc func handleLogin() {
//        setupUI()
        firstCountyAction?()
        print("banana")
    }

    @objc func handleSignUp() {
        secondCountryAction?()
    }
    
    @objc func handleConvert() {
        print("convertendo moedas")
    }
}
