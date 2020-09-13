//
//  ViewController.swift
//  BTG
//
//  Created by Renato Kuroe on 10/09/20.
//  Copyright © 2020 Renato Kuroe. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textFieldOriginValue: UITextField!
    @IBOutlet weak var labelConvertedValue: UILabel!
    @IBOutlet weak var spin: UIActivityIndicatorView!
    @IBOutlet weak var buttonOriginCurrency: UIButton!
    @IBOutlet weak var buttonDestinyCurrency: UIButton!
    
    var originCurrencyCode: String?
    var destinyCurrencyCode: String?
    var originQuote: Struct.Quote?
    var destinyQuote: Struct.Quote?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Variables.NAV_TITLE
        
        addDoneButtonOnKeyboard()
        self.textFieldOriginValue.delegate = self
    }
    
    @IBAction func actionOriginCurrency(_ sender: Any) {
        openCurrencyList(isOrigin: true)
    }
    
    @IBAction func actionDestinyCurrency(_ sender: Any) {
        openCurrencyList(isOrigin: false)
    }
    
    func openCurrencyList(isOrigin: Bool) {
        let vc = CurrencyListViewController()
        vc.mainViewController = self
        vc.isOrigin = isOrigin
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    
    func setOriginCurrency(currency: Struct.Currency) {
        self.originQuote = nil
        originCurrencyCode = currency.code
        self.buttonOriginCurrency.setTitle(currency.name + " (" + currency.code + ")", for: .normal)
        checkOriginDestinyQuotes()
    }
    
    func setDestinyCurrency(currency: Struct.Currency) {
        destinyCurrencyCode = currency.code
        self.buttonDestinyCurrency.setTitle(currency.name + " (" + currency.code + ")", for: .normal)
        checkOriginDestinyQuotes()
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Concluir", style: .done, target: self, action: #selector(doneButtonAction))
        
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        self.textFieldOriginValue.inputAccessoryView = doneToolbar
        self.textFieldOriginValue.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.textFieldOriginValue.resignFirstResponder()
        checkOriginDestinyQuotes()
    }
    
    func checkOriginDestinyQuotes() {
        // If setting origin quote
        if self.originQuote == nil {
            getCurrency(valueCurrency: originCurrencyCode!)
        } else {
            // If setting destiny quote
            getCurrency(valueCurrency: destinyCurrencyCode!)
        }
    }
    
    func tryToGetOfflineQuote() {
        self.originQuote = Utils.getQuote(name: originCurrencyCode!)
        self.destinyQuote = Utils.getQuote(name: destinyCurrencyCode!)
        
        // If not saved one of them
        if self.originQuote == nil || self.destinyQuote == nil {
            self.labelConvertedValue.text = ""
            Utils.showAlert(vc: self, message: Variables.NO_CURRENCY_AVAILABLE)
            return
        }
        
        self.calculateValuesFromUSD()
    }
    
    func getCurrency(valueCurrency: String) {
        if originCurrencyCode != nil && destinyCurrencyCode != nil{
            self.spin.startAnimating()
            
            guard let loanUrl = URL(string: Api.URL_LIVE + "&currencies=" + valueCurrency) else {
                return
            }
            let request = URLRequest(url: loanUrl)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                
                if ((error) != nil)  {
                    OperationQueue.main.addOperation({
                        self.spin.stopAnimating()
                        // If offline, try to get previous quotes that saved in persistent data
                        self.tryToGetOfflineQuote()
                    })
                    
                    return
                }
                Utils.saveSingleQuote(data: data!, name: valueCurrency)
                self.parseJsonData(data: data!)
            })
            task.resume()
        }
    }
    
    func parseJsonData(data: Data) {
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            let jsonCurrencies = jsonResult?["quotes"] as! Dictionary<String, NSNumber>
            for (key, value) in jsonCurrencies {
                if self.originQuote == nil {
                    self.originQuote = Struct.Quote(code: key, price: value)
                    OperationQueue.main.addOperation {
                        self.checkOriginDestinyQuotes()
                    }
                } else {
                    self.destinyQuote = Struct.Quote(code: key, price: value)
                    self.calculateValuesFromUSD()
                }
                return
            }
        } catch {
            Utils.showAlert(vc: self, message: error.localizedDescription)
        }
    }
    
    func calculateValuesFromUSD() {
        
        // Prevent crash in offline mode
        if self.originQuote == nil || self.destinyQuote == nil {
            return
        }
        
        OperationQueue.main.addOperation {
            // Convert origin currency to USD
            let amountValue = (self.textFieldOriginValue.text! as NSString).floatValue
            let originUSDValue = (self.originQuote?.price.floatValue)!
            let originAmountToUSD:Float = amountValue / originUSDValue
            
            // Convert USD Amount to Selected destiny quote
            let destinyUSDValue = (self.destinyQuote?.price.floatValue)!
            let destinyAmountFromUSD: Float = destinyUSDValue * originAmountToUSD;
            
            let twoDecimalPlaces = String(format: "%.2f", destinyAmountFromUSD)
            
            if (destinyAmountFromUSD == 0) {
                self.labelConvertedValue.text = ""
            } else {
                self.labelConvertedValue.text = String(self.destinyCurrencyCode! + " " + twoDecimalPlaces)
            }
            self.spin.stopAnimating()
        }
    }
    
    //MARK: - Text Field Delegates
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        calculateValuesFromUSD()
        return true;
    }
    
}
