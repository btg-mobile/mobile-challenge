//
//  ViewController.swift
//  Mobile Challenge
//
//  Created by Daive Costa Nardi Simões on 23/09/21.
//

import UIKit

class ConverterController: UIViewController, Storyboarded {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var lblSourceCurrency: UILabel!
    @IBOutlet weak var lblTargetCurrency: UILabel!
    @IBOutlet weak var txtValueToConvert: UITextField!
    @IBOutlet weak var txtConvertedValue: UILabel!
    @IBOutlet weak var btnConverter: UIButton!
    
    // MARK: - Public properties
    
    var coordinator: MainCoordinator?
    var viewModel: ConverterViewModel?
    
    // MARK: - Private properties
    
    private enum CurrencySelect {
        case source
        case target
    }
    
    private var selectedCurrency = CurrencySelect.source
    
    private var sourceCurrency: Currency?
    private var targetCurrency: Currency?
    private var convertedValue: Double?
        
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let currentCurrency = coordinator?.selectedCurrency else { return }
        
        switch selectedCurrency {
        case .source:
            sourceCurrency = currentCurrency
            lblSourceCurrency.text = sourceCurrency?.id
            
        case .target:
            targetCurrency = currentCurrency
            lblTargetCurrency.text = targetCurrency?.id
        }
        
        setConverterButtonStatus()
        
    }
    
    deinit {
        unbind()
    }
    
    // MARK: - Controller methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        txtValueToConvert.resignFirstResponder()
    }

    // MARK: - IBActions
    
    @IBAction func didChangeText(_ sender: Any) {
        setConverterButtonStatus()
    }
    
    @IBAction func didPressSourceCurrencyButton(sender: UITapGestureRecognizer) {
        selectedCurrency = .source
        coordinator?.goToCurrencyList()
    }
    
    @IBAction func didPressTargetCurrencyButton(sender: UITapGestureRecognizer) {
        selectedCurrency = .target
        coordinator?.goToCurrencyList()
    }
    
    @IBAction func didPressConvertButton(sender: UIButton) {
        guard let valueToConvert = txtValueToConvert.text, !valueToConvert.isEmpty, let value = Double(valueToConvert) else { return }
        
        viewModel?.sourceCurrency = sourceCurrency?.id
        viewModel?.targetCurrency = targetCurrency?.id
        
        viewModel?.convert(value: value)
    }
    
    @IBAction func didPressClearButton(sender: UIButton) {
        clear()
    }
    
    // MARK: - Private methods

    private func setConverterButtonStatus() {
        guard let valueToConvert = txtValueToConvert.text, !valueToConvert.isEmpty, let _ = Double(valueToConvert), sourceCurrency != nil, targetCurrency != nil else {
            btnConverter.isEnabled = false
            return
        }
        
        btnConverter.isEnabled = true
    }
    
    private func clear() {
        txtValueToConvert.text = ""
        txtConvertedValue.text = ""
        
        lblSourceCurrency.text = "-"
        sourceCurrency = nil
        lblTargetCurrency.text = "-"
        targetCurrency = nil
        
        setConverterButtonStatus()
    }

}

// MARK: - Binding Extension

extension ConverterController {
    
    private func bind() {
        NotificationCenter.default.addObserver(self, selector: #selector(showConvertedValue(_:)), name: NSNotification.Name(Constants.ConverterNotificationName.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showConversionError(_:)), name: NSNotification.Name(Constants.ConversionErrorNotificationName.rawValue), object: nil)
    }
    
    private func unbind() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(Constants.ConverterNotificationName.rawValue), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(Constants.ConversionErrorNotificationName.rawValue), object: nil)
    }
    
    @objc private func showConvertedValue(_ notification: Notification) {
        guard let convertedValue = notification.object as? Double else { return }
        DispatchQueue.main.async {
            self.txtConvertedValue.text = String(format: "%.2f", convertedValue)
        }
    }
    
    @objc private func showConversionError(_ notification: Notification) {
        guard let conversionError = notification.object as? Error else { return }
        print(conversionError.localizedDescription)
    }
    
}
