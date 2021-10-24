//
//  BTGCurrencyConverterViewController.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 21/10/21.
//

import Foundation
import UIKit

class BTGCurrencyConverterViewController: BTGBaseViewController<BTGCurrencyConverterView> {
    
    let viewModel: BTGCurrencyConverterViewModel
    
    init(viewModel: BTGCurrencyConverterViewModel) {
        self.viewModel = viewModel
        super.init()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTargets()
        bindViewModel()
        
        viewModel.fromCurrency = "EUR"
        viewModel.toCurrency = "BRL"
        viewModel.value(value: 2)
    }
}

fileprivate extension BTGCurrencyConverterViewController {
    func addTargets() {
        mainView.currencyTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        mainView.buttonFrom.addTarget(self, action: #selector(showFromPickerCurrencies), for: .touchUpInside)
        mainView.buttonTo.addTarget(self, action: #selector(showToPickerCurrencies), for: .touchUpInside)
    }
    
    func bindViewModel() {
        viewModel.didShowConvertedValue = { [unowned self] value in
            self.mainView.currencyConverterLabel.text = value
        }
        
        viewModel.didShowError = { error in
            print(error)
        }
    }
}

extension BTGCurrencyConverterViewController {
    @objc
    func textFieldDidChange(_ textField: UITextField) {        
        let val = textField.text!.isEmpty ? 0.0 : Float(textField.text!)
        viewModel.currentValue = val ?? 0
    }
    
    @objc private func showFromPickerCurrencies() {
        viewModel.showPickSupporteds(type: .from)
    }

    @objc private func showToPickerCurrencies() {
        viewModel.showPickSupporteds(type: .to)
    }
}
