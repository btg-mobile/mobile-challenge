//
//  ConvertViewController.swift
//  BtgConvert
//
//  Created by Albert Antonio Santos Oliveira - AOL on 30/04/21.
//

import Foundation
import UIKit
import PKHUD

protocol CountryCurrencySelectedDelegate {
    func select(model: CountryCurrencyModel)
}

class ConvertViewController: UIViewController {
           
    @IBOutlet weak var fromCurrencyButton: UIButton!
    @IBOutlet weak var toCurrencyButton: UIButton!
    @IBOutlet weak var convertValue: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var convertButton: UIButton!
    
    @IBOutlet weak var inputTextView: UIView!
    
    private var viewModel = ConvertViewModel()
    
    private var message: MessageDeletate = Message()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewConfiguration()
        self.viewModel.bindData()
    }
    
    @IBAction func didTapConvertButton(_ sender: UIButton) {
        guard let convertValue = convertValue.text, !convertValue.isEmpty else {
            message.showError(message: "Necessário informar o campo Valor")
            return
        }
        viewModel.convert(value: convertValue.toDoubleForced ?? 0.0)
    }
    
    @objc func myTextFieldDidChange(_ textField: UITextField) {
        if let amountString = textField.text?.toCurrrency {
            textField.text = amountString
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! CountryCurrencyViewController
        vc.set(delegate: self)
        viewModel.set(type: (segue.identifier == Storyboard.fromSegue ? .from : .to))
    }

}

extension ConvertViewController: CountryCurrencySelectedDelegate {
    func select(model: CountryCurrencyModel) {
        self.viewModel.set(model: model)
        
        DispatchQueue.main.async {
            guard self.viewModel.type == CurrencyTypeView.from else {
                self.toCurrencyButton.setTitle(model.getFormattedName(), for: .normal)
                return
            }
            self.fromCurrencyButton.setTitle(model.getFormattedName(), for: .normal)
        }
    }
}

extension ConvertViewController: ConvertControllerDelegate {
    func showResult(result: Double) {
        DispatchQueue.main.async {
            self.resultLabel.text = result.toDoubleForced ?? ""
        }
    }
}

extension ConvertViewController {
    func viewConfiguration() {
        // viewmodel delegate
        viewModel.set(delegate: self)
        
        // input event
        convertValue.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        convertValue.attributedPlaceholder = NSAttributedString(string: "Valor...",
                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        // button
        fromCurrencyButton.setRadius(with: 25)
        toCurrencyButton.setRadius(with: 25)
        convertButton.setRadius(with: 25)
        inputTextView.layer.cornerRadius = 25
    }
}
