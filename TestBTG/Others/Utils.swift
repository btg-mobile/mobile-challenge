//
//  Utils.swift
//  BTG
//
//  Created by Renato Kuroe on 11/09/20.
//  Copyright © 2020 Renato Kuroe. All rights reserved.
//

import UIKit

class Utils: NSObject {

    
    static public func showAlert(vc:UIViewController, message:String) {
        let alert = UIAlertController(title: Variables.WARNING, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Variables.OK, style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
    
    static public func saveCurrencyListData(data: Data) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "currencyList")
    }
    
    static public func getCurrencyList() -> [Struct.Currency]?{
        
        var currencies = [Struct.Currency]()
        
        do {
            let userDefaults = UserDefaults.standard
            
            // Check if list has been saved previously
            if userDefaults.object(forKey: "currencyList") == nil {
                return  nil
            }
            
            let data:Data =  userDefaults.object(forKey: "currencyList") as! Data
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            let jsonCurrencies = jsonResult?["currencies"] as! Dictionary<String, String>
            
            for (key, value) in jsonCurrencies {
                let currency = Struct.Currency(code: key, name: value)
                currencies.append(currency)
            }
                        
        } catch {
            return nil
        }
        
        currencies = currencies.sorted(by: { $0.name.lowercased() < $1.name.lowercased() })
        return currencies
    }
    
    static public func saveSingleQuote(data: Data, name: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: name)
    }
    
    static public func getQuote(name: String) -> Struct.Quote?{
        
        var quote = Struct.Quote(code: "", price: 0)
        
        do {
            let userDefaults = UserDefaults.standard
            
            // Check if quote has been saved previously
            if userDefaults.object(forKey: name) == nil {
                return  nil
            }
            
            let data:Data =  userDefaults.object(forKey: name) as! Data
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            let jsonCurrencies = jsonResult?["quotes"] as! Dictionary<String, NSNumber>
            
            for (key, value) in jsonCurrencies {
                quote = Struct.Quote(code: key, price: value)
            }
            
        } catch {
            return nil
        }
        
        return quote
    }
    
  
}
