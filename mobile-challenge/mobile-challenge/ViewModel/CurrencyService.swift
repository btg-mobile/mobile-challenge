//
//  CurrencyService.swift
//  mobile-challenge
//
//  Created by Fernanda Sudré on 25/11/20.
//

import Foundation

class CurrencyService {
    let url = "http://api.currencylayer.com/live?access_key=baa8ca67a82137316bb59b665428e101&currencies="
    
    var firstCurrency = ""
    var secondCurrency = ""
    
    var acronyms: [String] = []
    var currencyValues: [NSNumber] = []
    
    init() {
        
    }
    func fetch(){
        
        
        let session = URLSession.shared
        let linkURL = "\(url)\(firstCurrency),\(secondCurrency)"
        let urlApi = URL(string: linkURL)!

        let task = session.dataTask(with: urlApi) {data, response, error in
            guard error == nil else {
                print("Ocorreu um erro. \(String(describing: error))")
                return
            }
            
            var json: Any!
            do{
                json = try JSONSerialization.jsonObject(with: data!, options: [])
                if let dados = json as? [String:Any]{
                    let quotes = (dados["quotes"] as! Dictionary<String, NSNumber>)

                    self.acronyms = Array(quotes.keys)
                    self.currencyValues = Array(quotes.values)
                    let num1 = Double(self.currencyValues[0])
                    let num2 = Double(self.currencyValues[1])
                    print((num1)/(num2))
                }
                
            }catch {
                print("JSON error: \(error.localizedDescription)")
            }
            
        }
        task.resume()
    }
    
    
}
