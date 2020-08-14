//
//  CurrenciesList.swift
//  ConversorMoedas
//
//  Created by Ricardo Santana Lopes on 12/08/20.
//  Copyright © 2020 Ricardo Santana Lopes. All rights reserved.
//

import Foundation

class CurrenciesList {
    
    let urlLive = "http://api.currencylayer.com/list"
    let apiKey = "91d7f90d3fdeca18ef6186b9b76943ea"
    let format = "1"
    
    var urlRequest:String{
        "\(urlLive)?access_key=\(apiKey)&format=\(format)"
    }
    
    func getList(callback: @escaping CallBack){
        let task = URLSession.shared.dataTask(with: URL(string: urlRequest)!, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else {
                print("Tratar erro")
                return
            }
            
            var result: CurrencyResponse?
            do {
                result = try JSONDecoder().decode(CurrencyResponse.self, from: data)

                guard let currenciesList = result?.currencies else {return}
                print(currenciesList)
                callback(currenciesList)
            }
            catch {
                print("falha na conversao \(error.localizedDescription)")
            }
            
        })
        task.resume()
    }

    struct CurrencyResponse: Codable {
        let success: Bool
        let terms: String
        let privacy: String
        let currencies: [String: String]
    }
    
    typealias CallBack = ([String:String]) -> ()
}

