//
//  BTGCurrencyConverterViewController.swift
//  BTGConverterAPP
//
//  Created by Leonardo Maia Pugliese on 15/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import UIKit

class BTGCurrencyConverterVC: UIViewController {

    let titleView = UIView()
    let baseCurrencyCardView = BTGConverterCardItem(itemType: .base)
    let targetCurrencyCardView = BTGConverterCardItem(itemType: .target)
    let resultCurrencyView = BTGConverterResultCardItem()
    
    let horizontalPadding : CGFloat = 15
    let verticalPadding : CGFloat = 15
    let cardTitleLabelFontSize : CGFloat = 26
    
    var controller : CurrencyConverterController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configure() {
        
        configureController()
        configureTitleView()
        configureBaseCurrencyView()
        configureTargetCurrencyView()
        configureResultCurrencyView()
        createKeyboardGesture()
        
    }
    
    func configureBaseCurrencyView() {
        view.addSubview(baseCurrencyCardView)
        
        NSLayoutConstraint.activate([
            baseCurrencyCardView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: verticalPadding),
            baseCurrencyCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding),
            baseCurrencyCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding),
            baseCurrencyCardView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.22)
        ])
    }
    
    func configureTargetCurrencyView() {
        view.addSubview(targetCurrencyCardView)
        
        NSLayoutConstraint.activate([
            targetCurrencyCardView.topAnchor.constraint(equalTo: baseCurrencyCardView.bottomAnchor, constant: verticalPadding),
            targetCurrencyCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding),
            targetCurrencyCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding),
            targetCurrencyCardView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.22)
        ])
    }
    
    func configureResultCurrencyView() {
        view.addSubview(resultCurrencyView)
        resultCurrencyView.translatesAutoresizingMaskIntoConstraints = false
        resultCurrencyView.layer.cornerRadius = 13
        resultCurrencyView.backgroundColor = .systemBlue
        resultCurrencyView.convertButton.addTarget(self, action: #selector(convertValue), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            resultCurrencyView.topAnchor.constraint(equalTo: targetCurrencyCardView.bottomAnchor, constant: verticalPadding),
            resultCurrencyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding),
            resultCurrencyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding),
            resultCurrencyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    @objc private func convertValue() {
        
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
    
    @objc private func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        if notification.name != UIResponder.keyboardWillHideNotification &&
            self.view.frame.origin.y == 0 {
            self.view.frame.origin.y = 0 - keyboardScreenEndFrame.height + 120
        } else if notification.name == UIResponder.keyboardWillHideNotification &&
            self.view.frame.origin.y < 0 {
            self.view.frame.origin.y += keyboardScreenEndFrame.height - 120
        }
    }
    
    func configureController() {
        controller = BTGCurrencyConverterController()
    }
    
}

extension BTGCurrencyConverterVC: UITextFieldDelegate {
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        #warning("fazer aqui a conversão também")
        return true
    }
    

    
}
