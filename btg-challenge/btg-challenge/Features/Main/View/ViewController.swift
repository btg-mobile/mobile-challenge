//
//  ViewController.swift
//  btg-challenge
//
//  Created by Wesley Araujo on 13/09/20.
//  Copyright © 2020 Wesley Araujo. All rights reserved.
//

import UIKit

class ViewController: BaseViewController<MainViewModel> {
    
    
    @IBOutlet weak var currentCurrencyValueTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        currentCurrencyValueTextField.delegate = self
    }
    
    
    @IBAction func didPressOriginCurrencyButton(_ sender: UIButton) {
       if let controller = UIStoryboard(name: "CurrencySearchStoryboard", bundle: nil).instantiateViewController(withIdentifier: "CurrencySearchViewController") as? CurrencySearchViewController {
        
        self.present(controller, animated: true)
        
        }
    }
    
    
    @IBAction func didPressDestinyCurrencyButton(_ sender: Any) {
        if let controller = UIStoryboard(name: "CurrencySearchStoryboard", bundle: nil).instantiateViewController(withIdentifier: "CurrencySearchViewController") as? CurrencySearchViewController {
            
            controller.isSourceCurrencyActionCaller = false
            self.present(controller, animated: true)
        }
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        /*
         
         Add viewmodel to get convertion in real time and add
         in result label
        
         */
        
        if let associatedViewModel = associetedViewModel { associatedViewModel.getQuotesCurrency() }
        
        
        return true
    }
}

