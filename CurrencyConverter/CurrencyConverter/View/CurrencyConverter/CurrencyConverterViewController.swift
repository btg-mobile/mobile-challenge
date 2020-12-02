//
//  CurrencyConverterViewController.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 01/12/20.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    // MARK: - Properties
    private lazy var baseView = CurrencyConverterView()
    private lazy var viewModel = CurrencyConverterViewModel()
    
    weak var coordinator: MainCoordinator?
    
    
    // MARK: - View Life Cycle
    override func loadView() {
        super.loadView()
        self.view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupButtons()
        setupTextFields()
    }
}


// MARK: - Setup Navigation Bar
extension CurrencyConverterViewController {
    private func setupNavigationBar() {
        navigationItem.title = "Currency Converter"
    }
}

// MARK: - Setup Buttons
extension CurrencyConverterViewController {
    private func setupButtons() {
        baseView.sourceCurrencyTypeButton.addTarget(self, action: #selector(currencyTypeDidTouch(_:)), for: .touchUpInside)
        baseView.targetCurrencyTypeButton.addTarget(self, action: #selector(currencyTypeDidTouch(_:)), for: .touchUpInside)
        baseView.conversionButton.addTarget(self, action: #selector(convertCurrenciesButtonDidTouch), for: .touchUpInside)
    }
    
    private func setupTextFields() {
        baseView.sourceCurrencyValueTextField.addTarget(self, action: #selector(sourceCurrencyTextFieldDidChange(_:)), for: .editingChanged)
        baseView.targetCurrencyValueTextField.addTarget(self, action: #selector(targetCurrencyTextFieldDidTouch), for: .touchDown)
    }
}


// MARK: - Actions
extension CurrencyConverterViewController {
    @objc private func currencyTypeDidTouch(_ sender: UIButton) {
        // Identify type button
        if sender.tag == CurrencyTypeButtonTag.sourceCurrency.rawValue {
            print("Moeda origem")
        } else {
            print("Moeda destino")
        }
    }
    
    @objc private func sourceCurrencyTextFieldDidChange(_ textField: UITextField) {
        // Checando se algo foi digitado
        guard let typedText = textField.text else {
            print("Digite o valor a ser convertido")
            return
        }
        
        // Checando se é um número
        guard let typedValue = Double(typedText) else {
            print("Digite um valor numérico")
            return
        }
        
        print("Typed value:", typedValue)
    }
    
    @objc private func targetCurrencyTextFieldDidTouch() {
        print("targetCurrencyTextFieldDidTouch")
    }
    
    @objc private func convertCurrenciesButtonDidTouch() {
        do {
            let resultOfConversion = try viewModel.convertCurrencies()
            baseView.targetCurrencyValueTextField.text = String(resultOfConversion)
        } catch {
            print(error.localizedDescription)
        }
    }
}
