//
//  AnswersToApi.swift
//  convertMoneys
//
//  Created by Mateus Rodrigues Santos on 25/11/20.
//

import Foundation

protocol AnswerAllCurrencies {
    //All Currencies
    func currencies(url:String) -> [Int:String]
}

extension AnswerAllCurrencies{
    //All Currencies
    func currencies(url:String) -> [Int:String]{
        
        let request = Request()
        let data = request.peformRequest(url: url)
        
        print(data as Any)
        return [:]
    }
}

protocol AnswerTaxCurrencieOrigim {
    //All Currencies
    func currencies(url:String) -> Double
}

extension AnswerTaxCurrencieOrigim {
    
    //Change tax currency origim
    func currencieTaxOrigim(url:String) -> Double{
        
        let request = Request()
        let data = request.peformRequest(url: url)
        
        print(data as Any)
        
        return 0.0
    }
}

protocol AnswerTaxCurrencieDestiny {
    //All Currencies
    func currencies(url:String) -> Double
}

extension AnswerTaxCurrencieOrigim {
    
    //Change tax currency origim
    func currencieTaxDestiny(url:String) -> Double{
        
        let request = Request()
        let data = request.peformRequest(url: url)
        
        print(data as Any)
        
        return 0.0
    }
}
