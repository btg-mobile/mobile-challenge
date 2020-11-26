//
//  CurrencyViewModel.swift
//  convertMoneys
//
//  Created by Mateus Rodrigues Santos on 25/11/20.
//

import Foundation

enum CurrencyViewModelDestiny {
    case currencyOrigin
    case currencyDestiny
}
protocol CurrencyViewModelDelegate:class {
    func notifyChooseCurrency(nameCurrency:String,quote:Double,destiny:CurrencyViewModelDestiny)
}

class CurrencyViewModel {
    
    weak var delegate:CurrencyViewModelDelegate?
    
    let requisition = Request()
    
    var myDestinyData:CurrencyViewModelDestiny = .currencyOrigin
    
    var allCurrencies:[String:Double] = [:]
    var allCurrenciesNames:[String] = []
    
    func configureAllCurrencies() throws{
        requisition.allObservers.append(self)
        requisition.peformRequest(url: URLs.allCurrencies)
    }
    
    func configureCurrencyName(_ cell:CurrencyTableViewCell,_ index: Int){
        
        if let quoteR = allCurrencies[allCurrenciesNames[index]]{
            cell.quote = quoteR
        }
        
        cell.nameCurrency = allCurrenciesNames[index]
        
        let atualNameCurrency = allCurrenciesNames[index]
        
        if atualNameCurrency == "USDUSD"{
            cell.currencyLabel.text = "USD"
        }else{
            let newNameCurrency = atualNameCurrency.components(separatedBy: "USD")
            cell.currencyLabel.text = newNameCurrency[1]
        }
        
    }
}

extension CurrencyViewModel:ObserverRequest{
    func notifyEndRequest(_ dicionary: [String : Double]) {
     
        allCurrencies = dicionary
        for name in dicionary.keys {
            allCurrenciesNames.append(name)
        }
   
        requisition.allObservers.removeAll()
    }
}
