//
//  CountryCurrentResponse.swift
//  BtgConvert
//
//  Created by Albert Antonio Santos Oliveira - AOL on 30/04/21.
//

import Foundation

struct CountryCurrencyResponse: Codable {
    let success: Bool?
    let currencies: [String: String]?
    
    func getCurrencies() -> [CountryCurrencyModel] {
        guard let currencies = currencies else { return [CountryCurrencyModel]() }
        var countryCurrencyModel = [CountryCurrencyModel]()
        currencies.forEach { (key, value) in
            countryCurrencyModel.append(CountryCurrencyModel(name: value, ref: key))
        }
        return countryCurrencyModel
    }
}
