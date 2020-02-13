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
    
    private var selectedFrom : String?
    private var selectedTo : String?
    
    var controller : CurrencyController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.formatButton()
        
        self.controller = CurrencyController()
        
        //mudar temporatio
        self.controller?.delegate = self
        
        self.controller?.setupCurrencyListViewController()
        
        //Delegate and DataSource of PickerViews
        self.fromPickerView.delegate = self
        self.fromPickerView.dataSource = self
        self.toPickerView.delegate = self
        self.toPickerView.dataSource = self
        
    }
    
    func formatButton(){

        btnExchange.layer.cornerRadius = 10
        btnExchange.layer.borderWidth = 1
        btnExchange.layer.borderColor = UIColor.black.cgColor
        
    }

    @IBAction func btnGetExchange(_ sender: UIButton) {
        
        controller?.getCurrencyExchange(from: self.selectedFrom ?? "USD", to: self.selectedTo ?? "USD")
        
        
//WORKS PERFECLY
//        print(self.selectedFrom!)
//        print(self.selectedTo!)
//
//        let provider = CurrencyDataProvider(from: self.selectedFrom, to: self.selectedTo)
//
//        provider.getCurrentCurrencyValue { (Results) in
//
//            print("Peguei")
//
//            switch Results {
//            case .success(let exchange):
//                print(exchange.quotes!)
//                let dolar = exchange.quotes?.values
//
//                print(dolar ?? "")
//            case .failure(let error):
//                print("Erro \(error)")
//            }
//
//        }
//
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
