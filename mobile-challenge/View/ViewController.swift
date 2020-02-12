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
    
    private var selectedFrom : String?
    private var selectedTo : String?
    
    var controller : CurrencyController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.controller = CurrencyController()
        
        //mudar temporatio
        self.controller?.delegate = self
        
        self.controller?.setupCurrencyListViewController()

        //
        
        //Delegate and DataSource of PickerViews
        self.fromPickerView.delegate = self
        self.fromPickerView.dataSource = self
        self.toPickerView.delegate = self
        self.toPickerView.dataSource = self
        
    }
    
    @IBAction func btnGetExchange(_ sender: UIButton) {
        
        
        print(self.selectedFrom)
        print(self.selectedTo)
        
        //let fromCurrency = self.fromPickerView.value(forKey: <#T##String#>)
        //let toCurrency = self.toPickerView.value(forKey: <#T##String#>)
        
        
//        self.controller?.getCurrencyExchange(from: "BRL", to: "BDT"){
//
//        }
        
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
            self.selectedFrom = "Selecionou o item \(row)"
        case 1:
            self.selectedTo = "\(row)"
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
