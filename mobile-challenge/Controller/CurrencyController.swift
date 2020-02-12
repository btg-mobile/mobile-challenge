//
//  CurrencyController.swift
//  mobile-challenge
//
//  Created by Alan Silva on 10/02/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation

protocol CurrencyControllerDelegate: class {
    func successOnLoadingListOfCurrencies(currencyList: [String : String])
    func errorOnLoadingListOfCurrencies(error: CurrencyError)
}

class CurrencyController {
    
    weak var delegate : CurrencyControllerDelegate?
    
    private var currencyListArray : [Currency] = []
    private var notFilteredCurrencyListArray : [Currency] = []
    
    private var dataProvider : CurrencyDataProvider?
    
//MARK: - SETUP DE
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//MARK: - SETUP DE setupCurrencyListViewController
    
    func setupCurrencyListViewController(){
        
        dataProvider = CurrencyDataProvider()
        
        getAndSaveCurrencyList()
        
    }
    
    func getAndSaveCurrencyList(){
        
        self.dataProvider?.getListOfCurrencies(completion: { (results) in
            
            switch results {
            case .success(let currencyList):
                for (key, value) in currencyList {
                    let currency = Currency(key: key, value: value)
                    self.currencyListArray.append(currency)
                }
                
                self.currencyListArray.sort { 
                    $0.value < $1.value
                }
                self.notFilteredCurrencyListArray = self.currencyListArray
                self.delegate?.successOnLoadingListOfCurrencies(currencyList: currencyList)
                
            case .failure(let currencyError):
                self.delegate?.errorOnLoadingListOfCurrencies(error: currencyError)
            }
            
        })
        
    }
    
    func getNumberOfRowsInSection() -> Int {
        
        return self.currencyListArray.count
        
    }
    
    func loadCurrencyWithIndexPath(with indexPath: IndexPath) -> Currency {
        
        return self.currencyListArray[indexPath.row]
        
    }
    
    func updateArray(){
        self.currencyListArray = self.notFilteredCurrencyListArray
    }
    
    func searchByValue(searchText: String){
        
        guard !searchText.isEmpty else {
            self.currencyListArray = self.notFilteredCurrencyListArray
            return
        }
        
        self.currencyListArray = notFilteredCurrencyListArray.filter({ (Currency) -> Bool in
            (Currency.key.lowercased().contains(searchText.lowercased())) || (Currency.value.lowercased().contains(searchText.lowercased()))
        })
        
    }
    
}
