//
//  CurrencyConverterViewController.swift
//  mobile-challenge
//
//  Created by Brunno Andrade on 03/10/20.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    
    @IBOutlet weak var originButton: UIButton!
    @IBOutlet weak var destinyButton: UIButton!
    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var converterButton: UIButton!
    @IBOutlet weak var convertedLabel: UILabel!
    
    var viewModel = CurrencyConverterViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.title = viewModel.title
    }

    
    @IBAction func converterAction(_ sender: UIButton) {
        self.convertedLabel.text = "BRL >>> USD : 5,68"
    }
    
    @IBAction func originAction(_ sender: UIButton) {
        let vc = CurrencyListViewController(type: .origin)
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func destinyAction(_ sender: UIButton) {
        let vc = CurrencyListViewController(type: .destiny)
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func configureView() {
        self.originButton.layer.cornerRadius = 4
        self.destinyButton.layer.cornerRadius = 4
        self.currencyTextField.layer.cornerRadius = 4
        self.converterButton.layer.cornerRadius = 4
    }

}


extension CurrencyConverterViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension CurrencyConverterViewController: SelectCurrencyDelegate {
    func getSelectCurrency(type: TypeConverter, currency: Currency) {
        print("Type \(type) Code: \(currency.description)")
        
        switch type {
        case .origin:
            self.originButton.setTitle(currency.description, for: .normal)
        case .destiny:
            self.destinyButton.setTitle(currency.description, for: .normal)
        }
    }
    
}
