//
//  ViewController.swift
//  mobile-challenge
//
//  Created by Alan Silva on 10/02/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var fromPickerView: UIPickerView!
    @IBOutlet weak var toPickerView: UIPickerView!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var btnExchange: UIButton!
    @IBOutlet weak var currencyDescription: UILabel!
    
    private var selectedFrom : String?
    private var selectedTo : String?
    
    var controller : CurrencyController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.format()
        
        self.controller = CurrencyController()
        
        //mudar temporatio
        self.controller?.delegate = self
        
        self.controller?.setupCurrencyListViewController()
        
        //Delegate and DataSource of PickerViews
        self.fromPickerView.delegate = self
        self.fromPickerView.dataSource = self
        self.toPickerView.delegate = self
        self.toPickerView.dataSource = self
        
        self.amountTextField.delegate = self
        
    }
    
    func format(){
        
        self.amountTextField.keyboardType = .numbersAndPunctuation
        
        btnExchange.layer.cornerRadius = 10
        btnExchange.layer.borderWidth = 1
        btnExchange.layer.borderColor = UIColor.black.cgColor
        
    }
    
    @IBAction func btnGetExchange(_ sender: UIButton) {
        
        guard let amount = Double(self.amountTextField.text!) else {
            
            let alert = UIAlertController(title: "Atenção", message: "Informe o valor a ser convertido", preferredStyle: .alert)
            let btnOk = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
            
            alert.addAction(btnOk)
            
            self.present(alert, animated: true)
            
            return
        }
        
        guard let from = self.selectedFrom else { return }
        guard let to = self.selectedTo else { return }
        
        controller?.getCurrencyExchange(closure: { (conversion) in
            print(conversion)
            
            DispatchQueue.main.async {
                
                let formatter = NumberFormatter()
                formatter.locale = Locale.autoupdatingCurrent
                formatter.numberStyle = .decimal
                if let formattedAmount = formatter.string(from: Double(round(100*conversion)/100) as NSNumber) {
                    self.resultLabel.text = String(formattedAmount)
                }
                self.currencyDescription.text = self.controller?.getNameOfCurrencyWithCode(code: to)
            }
            
        }, amount: amount, from: from, to: to)
        
    }
    
}

extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.controller?.getNumberOfRowsInSection() ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.controller?.loadCurrencyTitleForRow(with: row)
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //CRIAR UM DELEGAT PARA OUVIR QUANDO HOUVER ALTERACAO
        
        switch pickerView.tag {
        case 0 :
            self.selectedFrom = self.controller?.loadCurrencyTitleForRow(with: row)
        case 1:
            self.selectedTo = self.controller?.loadCurrencyTitleForRow(with: row)
        default:
            return
        }
        
    }
    
}

//MARK: - EXTENSION OF CurrencyControllerDelegate

extension ViewController : CurrencyControllerDelegate {
    
    func successOnLoadingListOfCurrencies(currencyList: [String : String]) {
        
        DispatchQueue.main.async {
            
            self.fromPickerView.reloadAllComponents()
            self.toPickerView.reloadAllComponents()
            
        }
        
    }
    
    func errorOnLoadingListOfCurrencies(error: CurrencyError) {
        
        if !error.localizedDescription.isEmpty {
            
            DispatchQueue.main.async {
                
                let alerta = UIAlertController(title: "Erro", message: "Problema ao carregar os dados dos moedas", preferredStyle: .alert)
                let btnOk = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
                
                alerta.addAction(btnOk)
                
                self.present(alerta, animated: true)
                
            }
            
        }
        
    }
    
}

//MARK: - EXTENSION OF UITextFieldDelegate
extension ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.amountTextField {
            
            self.amountTextField.resignFirstResponder()
            
        }
        
        return true
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if(textField == self.amountTextField){
            let strLength = textField.text?.count ?? 0
            let lngthToAdd = string.count
            let lengthCount = strLength + lngthToAdd
            
            print(lengthCount)
            if lengthCount == 0 {
                
                self.amountTextField.resignFirstResponder()
                
            }
            
        }
        
        return true
        
    }
    
}
