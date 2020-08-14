//
//  Cotacao.swift
//  ConversorMoedas
//
//  Created by Ricardo Santana Lopes on 11/08/20.
//  Copyright © 2020 Ricardo Santana Lopes. All rights reserved.
//

import Foundation

class Quotation {
    
    let urlLive = "http://api.currencylayer.com/live"
    let apiKey = "91d7f90d3fdeca18ef6186b9b76943ea"
    let format = "1"
    
    func getLive(_ currencyKeyOrigin:String, _ currencyKeyDestiny:String, _ valueToConvert:Double, _ callBack: @escaping CallBack){
        
        var urlRequest:String{
            "\(urlLive)?access_key=\(apiKey)&currencies=\(currencyKeyOrigin),\(currencyKeyDestiny)&format=\(format)"
        }
        
        let task = URLSession.shared.dataTask(with: URL(string: urlRequest)!, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else {
                print("Tratar erro")
                return
            }
            
            var result: ConversorLive?
            do {
                result = try JSONDecoder().decode(ConversorLive.self, from: data)
                
                let keyChoiceOrigin = "USD\(currencyKeyOrigin)"
                let keyChoiceDestiny = "USD\(currencyKeyDestiny)"
                
                let dollarOrigin = result?.quotes[keyChoiceOrigin] ?? 0.0
                let dollarDestiny = result?.quotes[keyChoiceDestiny] ?? 0.0
             
                let resultConvert = CurrencyConverter().convertToSelectedCurrency(dollarOrigin, dollarDestiny, valueToConvert)
                
                callBack(resultConvert)
                
            }
            catch {
                print("falha na conversao \(error.localizedDescription)")
            }
        })
        task.resume()
    }


    struct ConversorLive: Codable {
        let success: Bool
        let terms: String
        let privacy: String
        let timestamp: Int
        let source: String
        let quotes: [String: Double]
    }

    typealias CallBack = (Double) -> ()

}
