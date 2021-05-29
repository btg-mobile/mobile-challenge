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
protocol CurrencyViewModelDelegateChooseCurrency:class {
    /**
     Notify what the currency that choose in tableView to ViewController
     - Authors: Mateus R.
     - Returns: nothing
     - Parameter nameCurrency:String
     - Parameter quote:Double
     - Parameter destiny:CurrencyViewModelDestiny
     */
    func notifyChooseCurrency(nameCurrency:String,quote:Double,destiny:CurrencyViewModelDestiny)
}

protocol CurrencyViewModelDelegateEndRequest:class {
    /**
     Notify the final of the request to create tableView
     - Authors: Mateus R.
     - Returns: nothing
     - Parameters: nothing
     */
    func notifyEndRequestForTableView()
}
class CurrencyViewModel {
    
    ///delegateChosseCurrency
    weak var delegateChosseCurrency:CurrencyViewModelDelegateChooseCurrency?
    ///delegateEndRequest
    weak var delegateEndRequest:CurrencyViewModelDelegateEndRequest?
    
    ///Object for create a request
    let requisition = Request()
    
    ///Indicate the destiny of data
    var myDestinyData:CurrencyViewModelDestiny = .currencyOrigin
    
    ///allCurrencies and quotes
    var allCurrencies:[String:Double] = [:]
    ///allCurrencies names
    var allCurrenciesNames:[String] = []
    
    /**
     Configure arrays and dictionarys
     - Authors: Mateus R.
     - Returns: nothing
     - Parameters: nothing
     */
    func configureAllCurrencies() throws{
        requisition.allObservers.append(self)
        requisition.peformRequest(url: URLs.allCurrencies)
    }
    
    /**
     Configure the text labels to show on cells
     - Authors: Mateus R.
     - Returns: nothing
     - Parameters: nothing
     */
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
        DispatchQueue.main.async { [weak self] in
            self?.allCurrencies = dicionary
            for name in dicionary.keys {
                self?.allCurrenciesNames.append(name)
            }
        
            self?.delegateEndRequest?.notifyEndRequestForTableView()
            self?.requisition.allObservers.removeAll()
        }
    }
}
