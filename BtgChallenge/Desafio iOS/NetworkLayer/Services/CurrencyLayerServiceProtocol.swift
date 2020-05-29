//
//  CurrencyLayerService.swift
//  Desafio iOS
//
//  Created by Lucas Soares on 28/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

typealias CurrencyListResult = (result: CurrenciesListResponse?, failure: Error?)
typealias CurrencyLiveResult = (result: CurrencyLiveResponse?, failure: Error?)

protocol CurrencyLayerServiceProtocol {
    func getCurrenciesList(onCompletion: @escaping((CurrencyListResult) -> Void))
    func getConversionRate(fromCoin: String, toCoin: String, onCompletion: @escaping ((CurrencyLiveResult) -> Void))
}
