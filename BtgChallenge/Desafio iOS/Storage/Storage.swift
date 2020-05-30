//
//  Storage.swift
//  Desafio iOS
//
//  Created by Lucas Soares on 30/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import Foundation
class Storage {
    
    // MARK: - Local Storage Properties
    private let userDefaults = UserDefaults.standard
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    init () {}
    
    private func saveToDisk<T: Codable>(currency: T) {
        if let encodedData = try? encoder.encode(currency) {
            userDefaults.set(encodedData, forKey: T.className)
        }
    }
    
    
}

extension Storage: StorageProtocol {
    func saveCurrencyList(response: CurrenciesListResponse) {
        saveToDisk(currency: response)
    }
    
    func saveCurrentRate(response: CurrencyLiveResponse) {
        if let savedResponse: CurrencyLiveResponse = getSavedInformation() {
            savedResponse.quotes?.forEach { element in
                if response.quotes?[element.key] == nil {
                    response.quotes?[element.key] = element.value
                }
            }
        }
        
        saveToDisk(currency: response)
    }
    
    func getSavedInformation<T: Decodable>() -> T? {
        if let object  = userDefaults.data(forKey: T.className) {
            let decodedObject = try? decoder.decode(T.self, from: object)
            
            return decodedObject
        }
        
        return nil
    }
}
