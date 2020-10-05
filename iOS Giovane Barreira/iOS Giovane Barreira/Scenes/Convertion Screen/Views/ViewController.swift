//
//  ViewController.swift
//  iOS Giovane Barreira
//
//  Created by Giovane Barreira on 10/2/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var amountConvertedLbl: UILabel!
    @IBOutlet weak var convertOriginBtn: UIButton!
    @IBOutlet weak var convertDestBtn: UIButton!
    
    var currencyOrigin: Double = 0
    var currencyDestination: Double = 0
    
    // MARK: - Properties
    var viewModel: CurrencyQuoteViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CurrencyQuoteViewModel()
        amountTextfield.keyboardType = .numberPad
    }

    @IBAction func currencyOriginBtn(_ sender: Any) {
        let pickerViewController = PickerViewController()
        pickerViewController.pickerOriginDelegate = self
        pickerViewController.modalPresentationStyle = .formSheet
        navigationController?.present(pickerViewController, animated: true)
    }
    
    @IBAction func currencyToConvertBtn(_ sender: Any) {
        let pickerViewController = PickerViewController()
        pickerViewController.pickerDestinationDelegate = self
        pickerViewController.modalPresentationStyle = .formSheet
        navigationController?.present(pickerViewController, animated: true)
    }
    
    @IBAction func convertBtn(_ sender: Any) {
        let convert = currencyDestination / currencyOrigin
        let userInputAsDouble = Double(amountTextfield.text ?? "") ?? 0.0
        let result = userInputAsDouble * convert
        let resultFormatted = String(format: "%.2f", result)
        amountConvertedLbl.text = String(resultFormatted)
    }
    
    @IBAction func currenciesSearchBtn(_ sender: Any) {
        let currenciesListVC = CurrenciesListViewController()
        navigationController?.pushViewController(currenciesListVC, animated: true)
    }
}

extension ViewController: PickerOriginDataDelegate {
    func currencyOriginValue(code: String, value: Double) {
        self.currencyOrigin = value
        convertOriginBtn.setTitle("Convert from: \(code)", for: .normal)
    }
}

extension ViewController: PickerDestinationDataDelegate {
    func currencyDestinationValue(code: String, value: Double) {
        self.currencyDestination = value
        convertDestBtn.setTitle("Convert to: \(code)", for: .normal)
    }
}
