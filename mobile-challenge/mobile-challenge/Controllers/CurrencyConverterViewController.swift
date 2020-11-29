//
//  CurrencyConverterViewController.swift
//  mobile-challenge
//
//  Created by gabriel on 29/11/20.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    
    // View Model
    let currencyConverter = CurrencyConverterViewModel()
    
    // UI Elements
    let contentStack: UIStackView = UIStackView(frame: .zero)
    
    let buttonsStack: UIStackView = UIStackView(frame: .zero)
    
    let originButtonStack: UIStackView = UIStackView(frame: .zero)
    let originCurrencyButton: UIButton = UIButton(frame: .zero)
    
    let destinyButtonStack: UIStackView = UIStackView(frame: .zero)
    let destinyCurrencyButton: UIButton = UIButton(frame: .zero)
    
    let textField: UITextField = UITextField(frame: .zero)
    
    let convertedCurrencyLabel: UILabel = UILabel(frame: .zero)
    
    let lastUpdateLabel: UILabel = UILabel(frame: .zero)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        setupUI()
    }
    
    private func setupBindings() {
        currencyConverter.quotesFetched = {
            self.updateData()
        }
    }
    
    private func updateData() {
        print(currencyConverter.quotes)
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        setupButtons()
        setupInputField()
        setupConvertedCurrencyLabel()
        setupLastUpdateLabel()
    }
    
    private func setupButtons() {
        // Setup buttonsStack attributes
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        buttonsStack.backgroundColor = .clear
        buttonsStack.axis = .horizontal
        buttonsStack.alignment = .center
        buttonsStack.distribution = .fill
        
        // Add ButtonsStack as subview
        view.addSubview(buttonsStack)
        
        // Setup buttonsStack constraints
        NSLayoutConstraint.activate([
            buttonsStack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            buttonsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            buttonsStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
        ])
        
        // Setup origin button
        setupSingleButton(label: "Origem:", stack: originButtonStack, button: originCurrencyButton, buttonTitle: "USD")
        
        // Setup center arrow
        let arrow = UILabel()
        arrow.text = "->"
        arrow.font = .boldSystemFont(ofSize: 36)
        arrow.adjustsFontSizeToFitWidth = true
        arrow.textAlignment = .center
        arrow.textColor = .white
        
        // Add arrow as subview of buttonsStack
        buttonsStack.addArrangedSubview(arrow)
        
        // Setup destiny button
        setupSingleButton(label: "Destino:", stack: destinyButtonStack, button: destinyCurrencyButton, buttonTitle: "BRL")
    }
    
    private func setupSingleButton(label: String, stack: UIStackView, button: UIButton, buttonTitle: String) {
        // Setup stack attributes
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .clear
        stack.axis = .vertical
        stack.spacing = 5
        
        // Add stack as subview of buttonsStack
        buttonsStack.addArrangedSubview(stack)
        
        // Setup upperLabel
        let upperLabel = UILabel()
        upperLabel.text = label
        upperLabel.textColor = .systemGray6
        
        // Add upperLabel as subview of stack
        stack.addArrangedSubview(upperLabel)
        
        // Setup button
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(buttonTitle, for: .normal)
        button.backgroundColor = .systemGray6
        button.setTitleColor(.systemGray, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(currencyButtonTapped(_:)), for: .touchUpInside)
        
        // Add button as subview of stack
        stack.addArrangedSubview(button)
        
        // Setup button constraints
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupInputField() {
        // Setup textField attributes
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.textAlignment = .center
        textField.adjustsFontSizeToFitWidth = true
        textField.font = .systemFont(ofSize: 20, weight: .heavy)
        textField.textColor = .systemGray
        textField.placeholder = "Entre com um valor"
        
        // Add textField as subview of view
        view.addSubview(textField)
        
        // Setup textField constraints
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: 30),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            textField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func setupConvertedCurrencyLabel() {
        // Setup convertedCurrencyLabel attributes
        convertedCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        convertedCurrencyLabel.font = .systemFont(ofSize: 40, weight: .heavy)
        convertedCurrencyLabel.adjustsFontSizeToFitWidth = true
        convertedCurrencyLabel.textAlignment = .center
        convertedCurrencyLabel.layer.masksToBounds = true
        convertedCurrencyLabel.layer.cornerRadius = 10
        convertedCurrencyLabel.backgroundColor = .systemGray6
        convertedCurrencyLabel.textColor = .systemGray
        convertedCurrencyLabel.text = ""
        
        
        // Add convertedCurrencyLabel as subview of view
        view.addSubview(convertedCurrencyLabel)
        
        // Setup convertedCurrencyLabel constraints
        NSLayoutConstraint.activate([
            convertedCurrencyLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30),
            convertedCurrencyLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            convertedCurrencyLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            convertedCurrencyLabel.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func setupLastUpdateLabel() {
        // Setup lastUpdateLabel attributes
        lastUpdateLabel.translatesAutoresizingMaskIntoConstraints = false
        lastUpdateLabel.adjustsFontSizeToFitWidth = true
        lastUpdateLabel.font = .systemFont(ofSize: 16, weight: .light)
        lastUpdateLabel.textAlignment = .center
        lastUpdateLabel.textColor = .systemGray6
        lastUpdateLabel.text = "Última atualização em: 01/01/2020 00:00"
        
        // Add lastUpdateLabel as subview of view
        view.addSubview(lastUpdateLabel)
        
        // Setup lastUpdateLabel constraints
        NSLayoutConstraint.activate([
            lastUpdateLabel.topAnchor.constraint(equalTo: convertedCurrencyLabel.bottomAnchor, constant: 30),
            lastUpdateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            lastUpdateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
        ])
    }
    
    @objc private func currencyButtonTapped(_ sender: UIButton) {
        print(sender)
    }
    
}
