//
//  LocalStorageController.swift
//  BTGConverterAPP
//
//  Created by Leonardo Maia Pugliese on 17/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import Foundation

protocol LocalStorage {
    func getLiveQuoteRates() -> LiveQuoteRates?
    func setLiveQuoteRates(_ liveQuoteRates: LiveQuoteRates)
    func getAvaliableQuotes() -> [CurrencyDescription]?
    func setAvaliableQuotes(_ avaliableDescriptions: [CurrencyDescription])
    
    func isLocalStorageValid(ofType type: LocalStorageDataType) -> Bool
}

enum LocalStorageDataType {
    case liveQuoteRates
    case avaliableQuotes
}

struct BTGLocalStorage : LocalStorage {
    
    func isLocalStorageValid(ofType type: LocalStorageDataType) -> Bool {
        let secondsToLive : Double = 300
        
        switch type {
        case .liveQuoteRates:
            guard let dateFromCache : Date = getFromLocalStorage(ofType: .timeToLiveLiveQuoteDate) else { return false }
            return dateFromCache.distance(to: Date()) < secondsToLive
        case .avaliableQuotes:
            guard let dateFromCache : Date = getFromLocalStorage(ofType: .timeToLiveAvaliableQuoteDate) else { return false }
            return dateFromCache.distance(to: Date()) < secondsToLive
        }
    }
    
    func getLiveQuoteRates() -> LiveQuoteRates? {
        print("get live quote rates cache")
        return getFromLocalStorage(ofType: .liveQuoteRates)
    }
    
    func setLiveQuoteRates(_ liveQuoteRates: LiveQuoteRates) {
        print("set live quote rates cache")
        saveToLocalStorage(data: liveQuoteRates, ofType: .liveQuoteRates)
        saveToLocalStorage(data: Date(), ofType: .timeToLiveLiveQuoteDate)
    }
    
    func getAvaliableQuotes() -> [CurrencyDescription]? {
        print("get avaliable quotes cache")
        return getFromLocalStorage(ofType: .avaliableCurrencies)
    }
    
    func setAvaliableQuotes(_ avaliableDescriptions: [CurrencyDescription]) {
        print("set avaliable quotes cache")
        saveToLocalStorage(data: avaliableDescriptions, ofType: .avaliableCurrencies)
        saveToLocalStorage(data: Date(), ofType: .timeToLiveAvaliableQuoteDate)
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
        return data
    }
}
