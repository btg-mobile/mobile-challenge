//
//  BTGCurrencyListController.swift
//  BTGConverterAPP
//
//  Created by Ana Caroline de Souza on 16/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import Foundation

protocol CurrencyListController {
    func loadCurrency()
    func getCurrencyToCurrencyReceiver()
}

class BTGCurrencyListController: CurrencyListController {

    private let networkController = BTGNetworkController.shared
    weak private var currencyListReceiver : CurrencyListReceiver?
    
    private var currencyDescriptionList : [CurrencyDescription] = [] {
        didSet {
            error = ""
        }
    }
    
    init(currencyListReceiver: CurrencyListReceiver) {
        self.currencyListReceiver = currencyListReceiver
    }
    
    private var error : String = ""
    
    func getCurrencyToCurrencyReceiver() {
        
        //        currencyDescriptionList += [CurrencyDescription(abbreviation: "BRL", fullDescription: "Aqui é BR"),
        //                                    CurrencyDescription(abbreviation: "BRL", fullDescription: "Aqui é BR"),
        //                                    CurrencyDescription(abbreviation: "USD", fullDescription: "USA USA USA")]
        if currencyDescriptionList.isEmpty {
            networkController.getAvaliableCurrencies {[weak self] result in
                switch result {
                case .success(let avaliableCurrencies):
                    self?.setCurrencyDescription(from: avaliableCurrencies)
                    guard let currencyListReceiver    = self?.currencyListReceiver ,
                          let currencyDescriptionList = self?.currencyDescriptionList else { return }
                    currencyListReceiver.setCurrencyDescriptions(currencyDescriptions: currencyDescriptionList)
                case .failure(let error):
                    #warning("tratar os erros aqui")
                    print("\(error)")
                }
            }
        }
    }
    
    func loadCurrency() {        
        networkController.getAvaliableCurrencies {[weak self] result in
            switch result {
            case .success(let avaliableCurrencies):
                self?.setCurrencyDescription(from: avaliableCurrencies)
            case .failure(let error):
                #warning("tratar os erros aqui")
                print("\(error)")
            }
        }
    }
    
    func setCurrencyDescription(from avaliableCurrencies: AvaliableCurrencies) {
        for (abbreviation, fullDescription) in avaliableCurrencies.currencies {
            let currencyDescription = CurrencyDescription(abbreviation: abbreviation, fullDescription: fullDescription)
            if !currencyDescriptionList.contains(currencyDescription) {
               currencyDescriptionList.append(CurrencyDescription(abbreviation: abbreviation, fullDescription: fullDescription))
            }
        }
    }
    
}
