//
//  HomeViewModel.swift
//  BTGPactual-HelioVieira
//
//  Created by Helio Junior on 07/08/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import Foundation

final class HomeViewModel {
    
    private let repository: HomeRepository!
    var didSuccessFetchData: (() -> ())?
    var didFailure: ((String) -> ())?
    var shouldUpdateExchangeValue: (() -> ())?
    let dispatchGroup = DispatchGroup()
    var quotes: Quotes?
    var currencies: Currencies?
    var currencyIn: Currency?
    var currencyOut: Currency?
    var valueInput: Double = 0
    var valueOutput: Double = 0
    
    init(_ repository: HomeRepository = HomeRepository()) {
        self.repository = repository
        
        currencyIn = Currency(code: "BRL", name: "Brazilian Real")
        currencyOut = Currency(code: "USD", name: "United States Dollar")
    }
    
    func fetchData() {
        dispatchGroup.enter()
        dispatchGroup.notify(queue: .main) {
            self.didSuccessFetchData?()
        }
        
        repository.fetchLive({ [weak self] quotes, error in
            self?.quotes = quotes!
            guard self?.currencies != nil else {return}
            self?.didSuccessFetchData?()
        })
        
        repository.fetchList({ [weak self] currencies, error in
            self?.currencies = currencies!
            guard self?.quotes != nil else {return}
            self?.didSuccessFetchData?()
        })
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 10) {
            self.dispatchGroup.suspend()
            
            if self.quotes == nil || self.currencies == nil {
                self.didFailure?("Não foi possivel estabelecer contato com o serviço.")
                return
            }
            self.didSuccessFetchData?()
        }
    }
    
    func converterCurrencies() {
        valueOutput = (calculateRatio() * valueInput)
        shouldUpdateExchangeValue?()
    }
    
    func getRatioBetwen2Currencies() -> String {
        let ration = calculateRatio()
        
        guard let currencyCodeIn = self.currencyIn?.code,
            let currencyCodeOut = self.currencyOut?.code,
            ration > 0
            else {return ""}
        
        return String(format: "1 %@ = %.2f %@", currencyCodeIn, ration, currencyCodeOut)
    }
    
    private func calculateRatio() -> Double {
        guard let currencyCodeIn = self.currencyIn?.code,
            let currencyCodeOut = self.currencyOut?.code,
            let priceIn = quotes?.getPriceQuote(to: currencyCodeIn),
            let priceOut = quotes?.getPriceQuote(to: currencyCodeOut)
            else {return 0}
        
        let valueToDolar = 1 / priceIn
        return valueToDolar * priceOut
    }
}
