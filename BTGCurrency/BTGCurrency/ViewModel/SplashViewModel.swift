//
//  SplashViewModel.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 02/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import Foundation

class SplashViewModel {
    let updateExpirationHours = 2
    
    let currencyClient: CurrencyClientProtocol
    let userDefaults: UserDefaultsProtocol
    
    init(currencyClient: CurrencyClientProtocol, userDefaults: UserDefaultsProtocol) {
        self.currencyClient = currencyClient
        self.userDefaults = userDefaults
    }
    
    //MARK: - Métodos principais
    func checkLastUpdate() {
        if let lastUpdate = userDefaults.getDate(key: .LastUpdate), !isDateExpired(date: lastUpdate, expirationHours: updateExpirationHours) {
            checkFavoriteCurrencies()
        } else {
            currencyClient.synchronizeQuotes {
                checkFavoriteCurrencies()
            }
        }
    }
    
    fileprivate func isDateExpired(date: Date, expirationHours: Int) -> Bool {
        let now = Date()
        let expiratedDate = Calendar.current.date(byAdding: .hour, value: expirationHours, to: date)!
        return now > expiratedDate
    }
    
    fileprivate func checkFavoriteCurrencies() {
        if let localCurrency = userDefaults.getString(key: .LocalCurrency), let foreignCurrency = userDefaults.getString(key: .ForeignCurrency) {
            
        } else {
            goToList()
        }
    }
    
    fileprivate func goToList() {
        Router.shared.setViewController(viewController: CurrenciesListViewController())
    }
    
    fileprivate func goToExchange(localCurrency: Currency, foreignCurrency: Currency) {
        
    }
}
