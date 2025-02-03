//
//  CurrencyViewModel.swift
//  Mobile Challenge
//
//  Created by Vinicius Serpa on 16/11/24.
//

import Foundation
import UIKit

class CurrencyViewModel {
    
    //MARK: Currency Arrays
    var currencyValues: [CurrencyValueModel] = []
    var currencyNames: [CurrencyNameModel] = []
    
    
    //MARK: API Strings
    var currencyNamesURL = URL(string: "https://raw.githubusercontent.com/Banking-iOS/mock-interview/main/api/list.json")
    var currencyValueURL =  URL(string: "https://raw.githubusercontent.com/Banking-iOS/mock-interview/main/api/live.json")
    
    //MARK: Pull Names Function
    func pullCurrencyNames(completion: @escaping () -> Void) {
        
        let task = URLSession.shared.dataTask(with: currencyNamesURL!) { data, _, _ in
            guard let data = data else {return}
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let currencies = json["currencies"] as? [String: String] {
                    let sortedCurrencies = currencies.sorted { $0.key < $1.key }
                    self.currencyNames = sortedCurrencies.map { CurrencyNameModel(code: $0.key, name: $0.value) }
                }
                
                completion()
                
            } catch {completion()}
        }
        task.resume()
    }
    
    //MARK: Pull Values Function
    func pullCurrencyValues(completion: @escaping () -> Void) {
        
        let task = URLSession.shared.dataTask(with: currencyValueURL!) { data, _, _ in
            guard let data = data else {return}
            
            do {
                let decodedResponse = try JSONDecoder().decode(CurrencyValueModel.self, from: data)
                let sortedQuotes = decodedResponse.quotes.sorted { $0.key < $1.key }
                self.currencyValues = sortedQuotes.map { CurrencyValueModel(quotes: [$0.key: $0.value])}
                
                completion()
                
            } catch {completion()}
        }
        task.resume()
    }
}
