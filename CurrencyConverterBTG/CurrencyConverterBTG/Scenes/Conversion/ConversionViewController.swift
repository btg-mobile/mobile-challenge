//
//  ConversionViewController.swift
//  CurrencyConverterBTG
//
//  Created by Silvia Florido on 18/06/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import UIKit

enum EmptyStateMessages: String {
    case loading = "Estamos carregando informações. \n Por favor aguarde um momento."
    case error = "Desculpe, não conseguimos carregar cotações dessa vez :( \n\n Poderia tentar mais tarde ?"
    case needCurrencies = "É necessário escolher duas moedas antes de converter."
    case needAmountToConvert = "É necessário inserir um valor a ser convertido."
    case currenciesAreEqual = "Você escolheu duas moedas iguais. \n Não é necessário converter."
}

class ConversionViewController: BaseController, CurrencyListViewControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var currencyViewFrom: CurrencyView!
    @IBOutlet weak var currencyViewTo: CurrencyView!
    @IBOutlet weak var amountToConvertTextField: UITextField!
    @IBOutlet weak var resultTextField: UITextField!
    @IBOutlet weak var emptyStateButton: UIButton!
    
    // to BTG code reviewer: the empty state view could be a separated component to be reused in all screens, did this way because was really out of time, Silvia Florido
    @IBOutlet weak var emptyStateView: UIView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    override var automaticallyAdjustsScrollViewInsetsForKeyboard: Bool {
        return true
    }
    
    weak var coordinator: MainCoordinator?
    var currencyFrom: Currency? {
        didSet{
            if let currency = currencyFrom {
                let viewModel = CurrencyViewModel(code: currency.code, name: currency.name, imageName: currency.code)
                currencyViewFrom.config(with: viewModel)
            }
        }
    }
    var currencyTo: Currency? {
        didSet {
            if let currency = currencyTo {
                let viewModel = CurrencyViewModel(code: currency.code, name: currency.name, imageName: currency.code)
                currencyViewTo.config(with: viewModel)
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Conversor de Moedas"
        displayEmptyView(onScreen: false, message: nil)
        configTextFields()
        fetchCurrencyList()
    }
    
    private func configTextFields() {
        amountToConvertTextField.delegate = self
        resultTextField.isUserInteractionEnabled = false
        amountToConvertTextField.inputAccessoryView = customToolbar
        resultTextField.inputAccessoryView = customToolbar
    }
    
    private func fetchCurrencyList() {
        displayEmptyView(onScreen: true, message: .loading)
        CurrencyLayerRepository.sharedInstance().getDefaultCurrencies { (currencies, error) in
            guard let currencies = currencies, currencies.count > 1 else {
                self.displayEmptyView(onScreen: true, message: .error)
                return
            }
            self.displayEmptyView(onScreen: false, message: nil)
            self.currencyFrom = currencies[0]
            self.currencyTo = currencies[1]
        }
    }
    
    // MARK: - Loading and Errors
    private func displayEmptyView(onScreen: Bool, message: EmptyStateMessages?, displayButton: Bool = false) {
        emptyStateView.isHidden = !onScreen
        if let message = message {
            errorMessageLabel.text = message.rawValue
        }
        emptyStateButton.isHidden = !displayButton
    }
    @IBAction func dismissEmptyViewButton(_ sender: UIButton) {
        displayEmptyView(onScreen: false, message: nil)
    }
    
    // MARK: - Currency Selections
    var selectingViewFrom: Bool = true
    @IBAction func selectFromCurrency(_ sender: CurrencyView) {
        selectingViewFrom = true
        coordinator?.selectCurrency(with: self)
    }
    
    @IBAction func selectToCurrency(_ sender: CurrencyView) {
        selectingViewFrom = false
        coordinator?.selectCurrency(with: self)
    }

    
    func didSelectCurrency(_ currency: Currency) {
        if selectingViewFrom {
            currencyFrom = currency
        } else {
            currencyTo = currency
        }
    }
    
    
    // MARK: - Conversion
    @IBAction func convertButton(_ sender: UIButton) {
        self.view.endEditing(true)
        guard let currencyFrom = currencyFrom, let currencyTo = currencyTo else {
            self.displayEmptyView(onScreen: true, message: .needCurrencies, displayButton: true)
            return
        }
        guard currencyTo != currencyFrom else {
            self.displayEmptyView(onScreen: true, message: .currenciesAreEqual, displayButton: true)
            return
        }
        guard let amountText = amountToConvertTextField.text, !amountText.isEmpty else {
            self.displayEmptyView(onScreen: true, message: .needAmountToConvert, displayButton: true)
            return
        }
        
        displayEmptyView(onScreen: true, message: .loading)
        CurrencyLayerRepository.sharedInstance().getLiveQuotes { (quotes, error) in
            guard let quotes = quotes else {
                self.displayEmptyView(onScreen: true, message: .error)
                return
            }
            self.displayEmptyView(onScreen: false, message: nil)
            if let amountDecimal = Decimal.fromString(amountText) {
                let conversion = Conversion(from: currencyFrom, to: currencyTo, fromAmount: amountDecimal, toAmount: nil, timestamp: nil)
                if let result = conversion.convert(with: quotes) {
                    self.resultTextField.text = result.toString()?.toCurrency()
                }
            } else {
                self.displayEmptyView(onScreen: true, message: .error)
            }
        }
    }
    
    
    // MARK: - Text Fields
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == amountToConvertTextField {
            resultTextField.text = ""
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let finalText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string).trimmingCharacters(in: .whitespacesAndNewlines) {
             textField.text = finalText.toCurrency()
        }
        return false
    }
    
    lazy var customToolbar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = false
        toolBar.sizeToFit()
        
        let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let okButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(self.doneTapped))
        let okAttrs = [NSAttributedString.Key.foregroundColor : UIColor.blue, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15.0, weight: .bold)]
        okButton.setTitleTextAttributes(okAttrs, for: .normal)
        okButton.setTitleTextAttributes(okAttrs, for: .highlighted)
        
        toolBar.setItems([flexibleSpaceButton, okButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }()
    
    @objc func doneTapped() {
        self.view.endEditing(true)
    }
   
}



// TO DO
/*
 testes unitarios
 
 imagem de fundo e melhorar layout
 
 tirar linha 88 chamado ao repo e passar para Conversion ?? por ultimo se sobrar tempo
 */
