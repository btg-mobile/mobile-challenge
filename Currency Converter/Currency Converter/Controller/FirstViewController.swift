//
//  FirstViewController.swift
//  Currency Converter
//
//  Created by Pedro Fonseca on 29/08/20.
//  Copyright © 2020 Pedro Bernils. All rights reserved.
//

import UIKit
import RealmSwift

class FirstViewController: UIViewController {

    @IBOutlet weak var textFrom: UITextField!
    @IBOutlet weak var textTo: UITextField!
    @IBOutlet weak var buttonFrom: UIButton!
    @IBOutlet weak var buttonTo: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var sourceRatio = 0 as Double
    var destinationRatio = 0 as Double
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let realm = try! Realm()

        try! realm.write {
            
            let selectedCurrencies = User.createIfNeeded(realm: realm)
            try! realm.commitWrite()
            
            buttonFrom.setTitle(selectedCurrencies.fromCurrency, for: .normal)
            buttonTo.setTitle(selectedCurrencies.toCurrency, for: .normal)

        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateCurrency), name: NSNotification.Name(rawValue: "update"), object: nil)
        updateCurrency()
    }
    
    @objc func updateCurrency() {
        
        let user = User.getMainUser()
        
        if let user = user {
            buttonFrom.setTitle(user.fromCurrency, for: .normal)
            buttonTo.setTitle(user.toCurrency, for: .normal)
            checkQuotes(fromCurrency: user.fromCurrency, toCurrency: user.toCurrency)
        }
    }
    
    func checkQuotes(fromCurrency: String, toCurrency: String) {
        
        print("Checking")
        
        let realm = try! Realm()
        
        let sourceCur = realm.object(ofType: Currency.self, forPrimaryKey: fromCurrency)
        let destinationCur = realm.object(ofType: Currency.self, forPrimaryKey: toCurrency)
        
        print(sourceCur != nil)
        
        let sourceOk = sourceCur?.isUpToDate(callback: { (status, error) in
            self.checkQuotes(fromCurrency: fromCurrency, toCurrency: toCurrency)
        })
            
        let destinationOk = destinationCur?.isUpToDate(callback: { (status, error) in
            self.checkQuotes(fromCurrency: fromCurrency, toCurrency: toCurrency)
        })
        
//        let message = String(sourceOk) + "|" + String(destinationOk)
//        print(message)
              
        if ((sourceOk ?? false) && (destinationOk ?? false)) {
            
            activityIndicator.stopAnimating()
            
            if let sourceQuote = realm.object(ofType: Quote.self, forPrimaryKey: sourceCur?.quoteId) {
                sourceRatio = sourceQuote.dollarRatio
            }
            
            if let destinationQuote = realm.object(ofType: Quote.self, forPrimaryKey: destinationCur?.quoteId) {
                destinationRatio = destinationQuote.dollarRatio
            }
            
            updateText()
            return
        }
        
        activityIndicator.startAnimating()
    }
    
    func updateText() {
        
        if (sourceRatio > 0.0 && destinationRatio > 0.0) {

            let sourceValue = Double(textFrom.text ?? "") ?? 0
            let destinationValue = sourceValue / sourceRatio * destinationRatio
            textTo.text = String(destinationValue)
        }
    }
 
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.destination is SecondViewController {
            let controller = segue.destination as? SecondViewController
            controller?.currencyPosition = (sender as! UIButton).tag
        }
    }
}

// MARK: - Extension
extension FirstViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty else {
            return true
        }

        let currentText = textField.text ?? ""
        let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)

        return replacementText.isDecimal()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateText()
    }
}

extension String{
   func isDecimal()->Bool{
       let formatter = NumberFormatter()
       formatter.allowsFloats = true
       formatter.locale = Locale.current
       return formatter.number(from: self) != nil
   }
}
