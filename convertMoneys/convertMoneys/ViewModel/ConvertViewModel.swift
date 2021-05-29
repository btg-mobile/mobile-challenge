//
//  ConvertViewModel.swift
//  convertMoneys
//
//  Created by Mateus Rodrigues Santos on 25/11/20.
//

import Foundation

enum ErrorsConvertViewModel:Error{
    case errorInConvertion
    case inputZero
}

class ConvertViewModel {
    
    ///The quote of the currencie value for convertion
    var atualQuoteOrigin:Double = 0.0
    ///The quote of the currencie value destiny of convertion
    var atualQuoteDestiny:Double = 0.0
    
    /**
     Configure the string for showing in Custom View labels
     - Authors: Mateus R.
     - Returns: nothing
     - Parameter atualNameCurrency: String
     - Parameter view: ConvertView
     - Parameter destiny: CurrencyViewModelDestiny
     - Parameter quote: Double
     */
    func configureCurrencyName(_ atualNameCurrency:String,view:ConvertView,destiny:CurrencyViewModelDestiny, quote:Double){
        
        if atualNameCurrency == "USDUSD"{
            if destiny == .currencyOrigin{
                view.currencyOrigin.text = "USD"
                atualQuoteOrigin = quote
            }else{
                atualQuoteDestiny = quote
                view.currencyDestiny.text = "USD"
            }
        }else{
            let newNameCurrency = atualNameCurrency.components(separatedBy: "USD")
            
            if destiny == .currencyOrigin{
                view.currencyOrigin.text = newNameCurrency[1]
                atualQuoteOrigin = quote
            }else{
                atualQuoteDestiny = quote
                view.currencyDestiny.text = newNameCurrency[1]
            }
        }
    }
    
    /**
     Method for calculate the convertion of a value in Double
     - Authors: Mateus R.
     - Returns valueAftherConvertion: Double
     - Parameter valueForConvertion: String
     - Parameter nameCurrencyOrigin: ConvertView
     - Parameter nameCurrencyDestny: CurrencyViewModelDestiny
     */
    func convert(valueForConvertion:Double,nameCurrencyOrigin:String,nameCurrencyDestny:String) throws -> Double{
        
        if nameCurrencyDestny == "NOTHING" || nameCurrencyOrigin == "NOTHING" || nameCurrencyDestny ==  "Escolha Uma Moeda" || nameCurrencyOrigin ==  "Escolha Uma Moeda"{
            throw ErrorsConvertViewModel.errorInConvertion
        }else if  valueForConvertion == 0.0{
            throw ErrorsConvertViewModel.inputZero
        }else{
            //Para dolar USD
            
            if nameCurrencyDestny == "USD" {
                return valueForConvertion * atualQuoteOrigin
            }
            
            if nameCurrencyOrigin == "USD"{
                return valueForConvertion * atualQuoteDestiny
            }
            
            //Para uma moeda qualquer

            //Transforma em dolar
            let dolar = valueForConvertion / atualQuoteOrigin
            //Calcula
            let result = dolar*atualQuoteDestiny
        
            return result
        }
    }
    
}
