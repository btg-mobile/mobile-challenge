//
//  CurrencyConverterBusinessModel.swift
//  DesafioBTG
//
//  Created by Bittencourt Mantavani, Rômulo on 02/09/20.
//  Copyright © 2020 Bittencourt Mantovani, Rômulo. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

class CurrencyConverterBusinessModel: CurrencyConversionProtocol, CurrencySelectorProtocol {    
    private let repository: CurrencyConverterRepository = CurrencyConverterRepository()
    
    var currencies: BehaviorSubject<[Currency]> = BehaviorSubject(value: [])
    var hasCurrencies: Bool {
        do {
            return try !currencies.value().isEmpty
        } catch {
            debugPrint(error)
            return false
        }
        
    }
    
    let fistSelectedCurrency:  BehaviorSubject<Currency?> = BehaviorSubject(value: nil)
    let secondSelectedCurrency:  BehaviorSubject<Currency?> = BehaviorSubject(value: nil)
    
    func rx_liveCurrencyValuesOfUSD() -> Observable<[JSON]> {
        repository.liveCurrencyValuesOfUSD().map { json -> [JSON] in
            json["quotes"].arrayValue
        }
    }
    
    func rx_currenciesList() -> Observable<[Currency]> {
        repository.currenciesList().map { json -> [Currency] in
            json["currencies"].arrayValue.map { object -> Currency in
                Currency(json: object.dictionaryValue)
            }
        }
    }
    
    func updateCurrency(value: Double, by code: String) {
        do {
            var currencyByCode = try self.currencies.value().first { $0.code == code }
            currencyByCode?.valueOfUSD = value
        } catch {
            debugPrint(error)
        }
    }
}
