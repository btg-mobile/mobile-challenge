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
    
    var atualQuoteOrigin:Double = 0.0
    var atualQuoteDestiny:Double = 0.0
    
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
    
    func convert(valueForConvertion:Double,nameCurrencyOrigin:String,nameCurrencyDestny:String) throws -> Double{
        
        if nameCurrencyDestny == "NOTHING" || nameCurrencyOrigin == "NOTHING" || nameCurrencyDestny ==  "Escolha Uma Moeda" || nameCurrencyOrigin ==  "Escolha Uma Moeda"{
            throw ErrorsConvertViewModel.errorInConvertion
        }else if  valueForConvertion == 0.0{
            throw ErrorsConvertViewModel.inputZero
        }else{
            //Para dolar USD
            if nameCurrencyDestny == "USD"{
                return valueForConvertion * atualQuoteOrigin
            }
            
            //Para uma moeda qualquer

            //Transforma em dolar
            let dolar = valueForConvertion * atualQuoteOrigin
            //Calcula
            let result = dolar/atualQuoteDestiny
        
            return result
        }
    }
    
}
