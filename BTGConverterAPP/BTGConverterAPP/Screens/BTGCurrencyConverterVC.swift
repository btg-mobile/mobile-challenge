//
//  BTGCurrencyConverterViewController.swift
//  BTGConverterAPP
//
//  Created by Leonardo Maia Pugliese on 15/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import UIKit

protocol CurrencyResultHandler: UIViewController {
    func setCurrencyConversionResult(currencyConvertedResult: String)
    func showErrorMessage(message: String)
}

protocol CurrencySelectionHandler: UIViewController {
    func setBaseCurrency(currencyAbbreviation: String)
    func setTargetCurrency(currencyAbbreviation: String)
}

enum AvaliableCurrencySelection {
    case base, target
}

class BTGCurrencyConverterVC: UIViewController, CurrencyResultHandler {
    
    let titleView = UIView()
    let baseCurrencyCardView = BTGConverterCardItem(itemType: .base)
    let targetCurrencyCardView = BTGConverterCardItem(itemType: .target)
    let resultCurrencyView = BTGConverterResultCardItem()
    
    let horizontalPadding : CGFloat = 15
    let verticalPadding : CGFloat = 15
    let cardTitleLabelFontSize : CGFloat = 26
    
    var currencyListModalView : BTGCurrencyListVC?
    var controller : CurrencyConverterController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func configure() {
        configureCurrencyListModalView()
        configureController()
        configureTitleView()
        configureBaseCurrencyView()
        configureTargetCurrencyView()
        configureResultCurrencyView()
        createKeyboardGesture()
    }
    
    private func configureCurrencyListModalView() {
        currencyListModalView = BTGCurrencyListVC(isModalView: true, currencySelectionHandler: self)
    }
    
    private func configureBaseCurrencyView() {
        view.addSubview(baseCurrencyCardView)
        
        baseCurrencyCardView.selectCurrencyButton.addTarget(self, action: #selector(showBaseCurrencyListButtonTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            baseCurrencyCardView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: verticalPadding),
            baseCurrencyCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding),
            baseCurrencyCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding),
            baseCurrencyCardView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.22)
        ])
    }
    
    private func configureTargetCurrencyView() {
        view.addSubview(targetCurrencyCardView)
        targetCurrencyCardView.selectCurrencyButton.addTarget(self, action: #selector(showTargetCurrencyListButtonTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            targetCurrencyCardView.topAnchor.constraint(equalTo: baseCurrencyCardView.bottomAnchor, constant: verticalPadding),
            targetCurrencyCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding),
            targetCurrencyCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding),
            targetCurrencyCardView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.22)
        ])
    }
    
    private func configureResultCurrencyView() {
        view.addSubview(resultCurrencyView)
        resultCurrencyView.translatesAutoresizingMaskIntoConstraints = false
        resultCurrencyView.layer.cornerRadius = 13
        resultCurrencyView.backgroundColor = .systemBlue
        resultCurrencyView.convertButton.addTarget(self, action: #selector(convertValueButtonTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            resultCurrencyView.topAnchor.constraint(equalTo: targetCurrencyCardView.bottomAnchor, constant: verticalPadding),
            resultCurrencyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding),
            resultCurrencyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding),
            resultCurrencyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    private func configureTitleView() {
        
        view.addSubview(titleView)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        titleView.backgroundColor = .systemPink
        
        let btgLabel = BTGTitleLabel(textAlignment: .left, fontSize: 36)
        titleView.addSubview(btgLabel)
        btgLabel.text = "BTG Converter"
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding ),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding),
            titleView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ])
    }
    
    private func createKeyboardGesture() {
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)

        resultCurrencyView.currencyTextField.delegate = self
    }
    
    private func configureController() {
        controller = BTGCurrencyConverterController(view: self)
    }
    
    func setCurrencyConversionResult(currencyConvertedResult: String) {
        resultCurrencyView.convertResultLabel.text = currencyConvertedResult
    }
    
    func showErrorMessage(message: String) {
        let ac = UIAlertController(title: "Error Occured!", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(ac,animated: true)
    }
    
    private func convertValueControllerCall() {
        if controller.validateUserInput(userValueInput: resultCurrencyView.currencyTextField.text,
                                        baseCurrency: baseCurrencyCardView.currencyLabel.text,
                                        targetCurrency: targetCurrencyCardView.currencyLabel.text) {
            resultCurrencyView.currencyTextField.resignFirstResponder()
            let decimal = Decimal(string: resultCurrencyView.currencyTextField.text!)!
            controller.getCurrencyConversion(baseCurrency: baseCurrencyCardView.currencyLabel.text!, targetCurrency: targetCurrencyCardView.currencyLabel.text!, inputDecimal: decimal)
        }
    }
    
    private func showCurrencyListButtonTap(_ avaliableCurrencySelection :AvaliableCurrencySelection) {
        currencyListModalView?.modalSelection = avaliableCurrencySelection
        let navController = UINavigationController(rootViewController: currencyListModalView!)
        present(navController,animated: true)
    }
    
    @objc private func convertValueButtonTap() {
        convertValueControllerCall()
    }
    
    @objc private func showTargetCurrencyListButtonTap() {
        showCurrencyListButtonTap(.target)
    }
    
    @objc private func showBaseCurrencyListButtonTap() {
        showCurrencyListButtonTap(.base)
    }
    
    @objc private func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        // view.safeAreaLayoutGuide.layoutFrame.origin.y
        #warning("testar isso depois ")
        if notification.name != UIResponder.keyboardWillHideNotification &&
            self.view.frame.origin.y == 0 {
            self.view.frame.origin.y = 0 - keyboardScreenEndFrame.height + 120
        } else if notification.name == UIResponder.keyboardWillHideNotification &&
            self.view.frame.origin.y < 0 {
            self.view.frame.origin.y += keyboardScreenEndFrame.height - 120
        }
    }
}

extension BTGCurrencyConverterVC: UITextFieldDelegate {
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        convertValueControllerCall()
        textField.resignFirstResponder()
        return true
    }
}

extension BTGCurrencyConverterVC: CurrencySelectionHandler {
    
    func setBaseCurrency(currencyAbbreviation: String) {
        baseCurrencyCardView.currencyLabel.text = currencyAbbreviation
    }
    
    func setTargetCurrency(currencyAbbreviation: String) {
        targetCurrencyCardView.currencyLabel.text = currencyAbbreviation
    }
    
    
}
