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
            currencyClient.synchronizeQuotes { result in
                switch result {
                case .success():
                    self.setSynchronized()
                    self.checkFavoriteCurrencies()
                case .failure(let error):
                    var msg = ""
                    switch error {
                    case .InvalidURL:
                        msg = "Não foi possível encontrar o serviço de câmbio."
                    case .ServerError:
                        msg = "Estamos melhorando nossos serviços."
                    case .InvalidResponse:
                        msg = "Não foi possível ler os valores de câmbio recebidos."
                    }
                    msg += " Tente novamente mais tarde"
                    alert(title: "Atenção!", message: msg)
                }
            }
        }
    }
    
    fileprivate func isDateExpired(date: Date, expirationHours: Int) -> Bool {
        let now = Date()
        let expiratedDate = Calendar.current.date(byAdding: .hour, value: expirationHours, to: date)!
        return now > expiratedDate
    }
    
    fileprivate func setSynchronized() {
        userDefaults.putDate(key: .LastUpdate, value: Date())
    }
    
    fileprivate func checkFavoriteCurrencies() {
        if let localCurrencyAbbreviation = userDefaults.getString(key: .LocalCurrency),
            let foreignCurrencyAbbreviation = userDefaults.getString(key: .ForeignCurrency),
            let localCurrency = CurrencyData.get(forAbbreviation: localCurrencyAbbreviation),
            let foreignCurrency = CurrencyData.get(forAbbreviation: foreignCurrencyAbbreviation) {
            goToExchange(localCurrency: localCurrency, foreignCurrency: foreignCurrency)
        } else {
            goToList()
        }
    }
    
    fileprivate func goToList() {
        Router.shared.setViewController(viewController: CurrenciesListViewController())
    }
    
    fileprivate func goToExchange(localCurrency: Currency, foreignCurrency: Currency) {
        Router.shared.setViewController(viewController: ExchangeViewController(localCurrency: localCurrency, foreignCurrency: foreignCurrency))
    }
}
