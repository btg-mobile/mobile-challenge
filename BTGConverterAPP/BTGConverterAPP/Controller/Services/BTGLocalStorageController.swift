//
//  LocalStorageController.swift
//  BTGConverterAPP
//
//  Created by Ana Caroline de Souza on 17/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import Foundation

protocol LocalStorage {
    
    func isValid()-> Bool
    func getLiveQuoteRates() -> LiveQuoteRates?
    func setLiveQuoteRates(_ liveQuoteRates: LiveQuoteRates)
    func getAvaliableQuotes() -> [CurrencyDescription]?
    func setAvaliableQuotes(_ avaliableDescriptions: [CurrencyDescription])
    
}

enum LocalStorageDataType {
    case liveQuoteRates
    case avaliableQuotes
}

struct BTGLocalStorage : LocalStorage {
    
    func isValid() -> Bool {
        guard let dateFromCache : Date = getFromLocalStorage(ofType: .timeToLiveDate) else { return false }
        
        print(dateFromCache.distance(to: Date()),"is valid distance from cache")
        let secondsToLive : Double = 300
        
        return dateFromCache.distance(to: Date()) > secondsToLive
    }
    
    func getLiveQuoteRates() -> LiveQuoteRates? {
        print("get live quote cached")
        return getFromLocalStorage(ofType: .liveQuoteRates)
    }
    
    func setLiveQuoteRates(_ liveQuoteRates: LiveQuoteRates) {
        print("setLive quote rates")
        saveToLocalStorage(data: liveQuoteRates, ofType: .liveQuoteRates)
        saveToLocalStorage(data: Date(), ofType: .timeToLiveDate)
    }
    
    func getAvaliableQuotes() -> [CurrencyDescription]? {
        print("get avaliable quotes")
        return getFromLocalStorage(ofType: .avaliableCurrencies)
    }
    
    func setAvaliableQuotes(_ avaliableDescriptions: [CurrencyDescription]) {
        print("set avaliable quotes")
        saveToLocalStorage(data: avaliableDescriptions, ofType: .avaliableCurrencies)
        saveToLocalStorage(data: Date(), ofType: .timeToLiveDate)
    }
    
    
    private func saveToLocalStorage<T:Encodable>(data: T,ofType localCacheKeys: LocalCacheKeys ) {
        let jsonEncoder = JSONEncoder()
        guard let savedData = try? jsonEncoder.encode(data) else { return }
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: localCacheKeys.rawValue)
    }
    
    private func getFromLocalStorage<T:Decodable>(ofType localCacheKeys: LocalCacheKeys) -> T? {
        
        var data: T? = nil
        
        let defaults = UserDefaults.standard
        guard let savedData = defaults.object(forKey: localCacheKeys.rawValue) as? Data else { return data }
        let jsonDecoder = JSONDecoder()
        do {
            data = try jsonDecoder.decode(T.self, from: savedData)
        } catch {
            print("data couldn't be retrieved")
        }
        //print(data)
        return data
    }
}
