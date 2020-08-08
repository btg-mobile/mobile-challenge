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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showLoading()
    }
    
    // MARK: Actions
    @IBAction func handlerCurrencyInput(_ sender: Any) {
    }
    
    @IBAction func handlerCurrencyOutput(_ sender: Any) {
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
        lblInputCurrencyCode.text = viewModel.currencyCodeIn
        lblInputCurrencyName.text = viewModel.currencyNameIn
        lblOutputCurrencyCode.text = viewModel.currencyCodeOut
        lblOutputCurrencyName.text = viewModel.currencyNameOut
        lblOutputValue.text = String(format: "%.2f", viewModel.valueOutput)
        lblRationCurrencies.text = viewModel.getRatioBetwen2Currencies()
    }
    
    @objc func didEditingChangeInputValue(_ textField: UITextField) {
        guard let text = textField.text, let value = Double(text) else {return}
        viewModel.valueInput = value
    }
}
