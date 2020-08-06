//
//  ExchangeViewController.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 02/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController {
    let viewModel: ExchangeViewModel
    @IBOutlet weak var localTextField: UITextField!
    @IBOutlet weak var foreignTextField: UITextField!
    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var foreignLabel: UILabel!
    @IBOutlet weak var contentBottomConstraint: NSLayoutConstraint!
    
    init(localCurrency: Currency, foreignCurrency: Currency) {
        self.viewModel = ExchangeViewModel(localCurrency: localCurrency, foreignCurrency: foreignCurrency)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("🔥")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createKeyboardObserver()
        configTextFields()
        viewModel.setLabels(localLabel: localLabel, foreignLabel: foreignLabel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        localTextField.becomeFirstResponder()
    }

    @IBAction func changeCurrencies(_ sender: Any) {
        viewModel.goToList()
    }
}

//MARK: - Configuração do teclado
extension ExchangeViewController {
    func createKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillAppear(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        contentBottomConstraint.constant = keyboardSize + 8
    }

    @objc func keyboardWillDisappear(sender: NSNotification) {
        contentBottomConstraint.constant = 8
    }
}

//MARK: - Configuração do textfield
extension ExchangeViewController {
    func configTextFields() {
        localTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    @objc func textFieldDidChange(textField: UITextField){

        if let value = Double(textField.text!) {
            let convertedValue = viewModel.convertLocalToForeign(value: value)
            foreignTextField.text = "\(convertedValue)"
        }
    }
}
