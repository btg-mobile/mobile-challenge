//
//  ConversionViewController.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu on 25/09/21.
//

import UIKit

class ConversionViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        setupView()
        
    }
    
    var viewModel: ConversionViewModel?
    var textFieldEnableCount = 0
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .white
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    private lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 0.8
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "0.00"
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange),
                                  for: .editingChanged)
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    private lazy var convertedValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 40)
        label.sizeToFit()
        return label
    }()
    
    private lazy var initialCurrencyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tappedInitialCurrency), for: .touchUpInside)
        button.setTitle("Selecione Moeda inicial", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private lazy var finalCurrencyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tappedFinalCurrency), for: .touchUpInside)
        button.setTitle("Selecione Moeda final", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    func tapAnywhereOnScreenToDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func textChanged(text: String) {
        viewModel?.onValueChange(value: Float(text) ?? 0)
    }
    
    @objc func tappedInitialCurrency() {
        if let viewModel = viewModel as? CurrencyListViewModel {
            let vc = CurrencyListScreenFactory.buildCurrencyListScreen(viewModel: viewModel, isInitial: true)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func tappedFinalCurrency() {
        if let viewModel = viewModel as? CurrencyListViewModel {
            let vc = CurrencyListScreenFactory.buildCurrencyListScreen(viewModel: viewModel, isInitial: false)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func setupTextFields() {
            let toolbar = UIToolbar()
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
            let doneButton = UIBarButtonItem(title: "Done", style: .done,
                                             target: self, action: #selector(doneButtonTapped))
            
            toolbar.setItems([flexSpace, doneButton], animated: true)
            toolbar.sizeToFit()
            
            inputTextField.inputAccessoryView = toolbar
        }
        
        @objc func doneButtonTapped() {
            view.endEditing(true)
        }
    
    func enableInputTextField() {
        textFieldEnableCount = 0
        inputTextField.isUserInteractionEnabled = true
        inputTextField.layer.borderColor = UIColor.gray.cgColor
    }
}

extension ConversionViewController: UITextFieldDelegate {
    @objc func textFieldDidChange() {
        if let text = inputTextField.text {
            textChanged(text: text)
        }
    }
}

extension ConversionViewController: ConversionViewModelDelegate {
    func convertedValueDidChange(value: Float) {
        convertedValueLabel.text = String(value)
    }
    
    func initialCurrencyDidChange(currency: String) {
        initialCurrencyButton.setTitle(currency, for: .normal)
        textFieldEnableCount+=1
        if textFieldEnableCount == 2 {
            enableInputTextField()
        }
    }
    
    func finalCurrencyDidChange(currency: String) {
        finalCurrencyButton.setTitle(currency, for: .normal)
        textFieldEnableCount+=1
        if textFieldEnableCount == 2 {
            enableInputTextField()
        }
    }
}

extension ConversionViewController: ViewCode {
    func buildViewHierarchy() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(convertedValueLabel)
        stackView.addArrangedSubview(inputTextField)
        stackView.addArrangedSubview(initialCurrencyButton)
        stackView.addArrangedSubview(finalCurrencyButton)
    }
    
    func setupConstraints() {
        convertedValueLabel.anchor(widthConstant: 200, heightConstant: 40)
        inputTextField.anchor(widthConstant: 200, heightConstant: 40)
        initialCurrencyButton.anchor(widthConstant: 200, heightConstant: 40)
        finalCurrencyButton.anchor(widthConstant: 200, heightConstant: 40)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 150, rightConstant: 20)
    }
    
    func additionalConfigurations() {
        view.backgroundColor = .white
        setupTextFields()
        tapAnywhereOnScreenToDismissKeyboard()
    }
}

