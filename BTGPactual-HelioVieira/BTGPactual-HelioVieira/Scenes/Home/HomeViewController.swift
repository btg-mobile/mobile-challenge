//
//  HomeViewController.swift
//  BTGPactual-HelioVieira
//
//  Created by Helio Junior on 07/08/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    let viewModel = HomeViewModel()
    
    // MARK: Outlets
    @IBOutlet weak var edtInputValue: UITextField!
    @IBOutlet weak var lblOutputValue: UILabel!
    @IBOutlet weak var lblInputCurrencyCode: UILabel!
    @IBOutlet weak var lblInputCurrencyName: UILabel!
    @IBOutlet weak var lblOutputCurrencyCode: UILabel!
    @IBOutlet weak var lblOutputCurrencyName: UILabel!
    @IBOutlet weak var lblRationCurrencies: UILabel!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edtInputValue.addTarget(self, action: #selector(didEditingChangeInputValue(_:)), for: .editingChanged)
        
        bindEvents()
        viewModel.fetchData()
        showLoading()
    }
    
    // MARK: Actions
    @IBAction func handlerCurrencyInput(_ sender: Any) {
        guard let currencies = viewModel.currencies else {return}
        
        let currenciesVC = CurrenciesViewController.builder(mode: .input,
                                                            currencies: currencies.toList())
        currenciesVC.didSelectCurrency = { [weak self] currency in
            self?.viewModel.currencyIn = currency
            self?.viewModel.converterCurrencies()
        }
        self.navigationController?.pushViewController(currenciesVC, animated: true)
    }
    
    @IBAction func handlerCurrencyOutput(_ sender: Any) {
        guard let currencies = viewModel.currencies else {return}
        
        let currenciesVC = CurrenciesViewController.builder(mode: .output,
                                                            currencies: currencies.toList())
        currenciesVC.didSelectCurrency = { [weak self] currency in
            self?.viewModel.currencyOut = currency
            self?.viewModel.converterCurrencies()
        }
        self.navigationController?.pushViewController(currenciesVC, animated: true)
    }
    
    // MARK: Helpers
    private func bindEvents() {
        viewModel.didSuccessFetchData = { [weak self] in
            DispatchQueue.main.async {
                self?.closeLoading()
                self?.edtInputValue.becomeFirstResponder()
            }
        }
        
        viewModel.didFailure = { [weak self] error in
            self?.closeLoading()
            print("==> Error: \(error)")
        }
        
        viewModel.shouldUpdateExchangeValue = { [weak self] in
            self?.updateUI()
        }
    }
    
    private func updateUI() {
        lblInputCurrencyCode.text = viewModel.currencyIn?.code
        lblInputCurrencyName.text = viewModel.currencyIn?.name
        lblOutputCurrencyCode.text = viewModel.currencyOut?.code
        lblOutputCurrencyName.text = viewModel.currencyOut?.name
        lblOutputValue.text = String(format: "%.2f", viewModel.valueOutput)
        lblRationCurrencies.text = viewModel.getRatioBetwen2Currencies()
    }
    
    @objc func didEditingChangeInputValue(_ textField: UITextField) {
        guard let text = textField.text, let value = Int(text) else {return}
        textField.text = value.description
        viewModel.valueInput = Double(value)
        viewModel.converterCurrencies()
    }
}
