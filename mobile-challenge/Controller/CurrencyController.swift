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
    private var sortedCurrencyListArray : [Currency] = []
    private var notFilteredCurrencyListArray : [Currency] = []
    private var exchangeArray: [Double] = []
    
    private var dataProvider : CurrencyDataProvider?
    
    //MARK: - SETUP ViewController
    
    func setupViewController(){
        
        dataProvider = CurrencyDataProvider()
    
    }
    
    func getCurrencyExchange(closure: @escaping(Double) -> Void, amount: Double, from: String, to: String) {
        
        let provider = CurrencyDataProvider(from: from, to: to)
        
        provider.getCurrentCurrencyValue { [weak self] Results in
            
            switch Results {
            case .success(let exchange):
            
                guard let firstValue = exchange.quotes?["USD\(from)"] else { return }
                guard let secondValue = exchange.quotes?["USD\(to)"] else { return }

                closure((self?.calculate(amount: amount, value1: firstValue, value2: secondValue))!)
                
            case .failure(let error):
                print("Erro \(error)")
                self?.delegate?.errorOnLoadingListOfCurrencies(error: error)
            }
            
        }
        
    }
    
    func calculate(amount: Double, value1: Double, value2: Double) -> Double {
        
        let fromToDolar = (amount / value1)
        let result = fromToDolar * value2
        
        return result
    }
    
    //Title for PickerView
    func loadCurrencyTitleForRow(with index: Int) -> String {
        
        return self.sortedCurrencyListArray[index].key
        
    }
    
    func getNameOfCurrencyWithCode(code: String) -> String {
        
        var codeStr = ""
        
        for i in self.currencyListArray {
            
            if i.key == code {
                codeStr = i.value
            }
            
        }
        
        return codeStr
    }
    
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
                self.sortedCurrencyListArray = self.currencyListArray
                self.sortedCurrencyListArray.sort {
                    $0.key < $1.key
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
