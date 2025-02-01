//
//  ConvertionViewModel.swift
//  Mobile Challenge
//
//  Created by Vinicius Serpa on 19/11/24.
//

import Foundation

class ConversionViewModel {
    
    let currencyVM: CurrencyViewModel = CurrencyViewModel()
    var convertions: [ConversionModel] = []
    
    
    //MARK: Integrate CurrencyName With CurrencyCode
    
    func fetchConvertions() {
        
        let dispatchGroup = DispatchGroup()
        
        //Runs Asynchronously
        dispatchGroup.enter()
        currencyVM.pullCurrencyValues {
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        currencyVM.pullCurrencyNames {
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
          
            //Append currency name and relative curency code in a new array
            
            let count = self.currencyVM.currencyNames.count
            
            for index in 0..<count {
                let currencyName = self.currencyVM.currencyNames[index]
                let currencyCode = self.currencyVM.currencyValues[index]
                
                if let dolarValue = currencyCode.quotes.values.first {
                    let newElement = ConversionModel(code: currencyName.code, dolarValue: dolarValue)
                    self.convertions.append(newElement)
                }
                
            }
        }
    }
}

