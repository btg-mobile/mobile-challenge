//
//  CurrencyTypesService.swift
//  mobile-challenge
//
//  Created by Fernanda Sudré on 25/11/20.
//

import Foundation

class CurrencyTypesService{
    
    var quotes: Dictionary<String, String> = [:]
    var acronyms: [String] = []
    var currencyNames: [String] = []
    
   
    init() {
        fetchCurrencyTypes()
    }
    
    func fetchCurrencyTypes(){
        let url = "http://api.currencylayer.com/list?access_key=baa8ca67a82137316bb59b665428e101"
        let session = URLSession.shared
        let linkURL = "\(url)"
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
                    
                    self.quotes = (dados["currencies"] as? Dictionary<String, String>)!
                    self.acronyms = Array(self.quotes.keys)
                    self.currencyNames = Array(self.quotes.values)

                }
                
            }catch {
                print("JSON error: \(error.localizedDescription)")
            }
            
        }
        task.resume()
    }
    
    func sendAcronyms() -> Array<String>{
        return self.acronyms
    }
    
    func sendCurrencyNames() -> Array<String>{
        return self.currencyNames
    }
}
