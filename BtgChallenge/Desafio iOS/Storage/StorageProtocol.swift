//
//  StorageProtocol.swift
//  Desafio iOS
//
//  Created by Lucas Soares on 30/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import Foundation
protocol StorageProtocol {
    func saveCurrencyList(response: CurrenciesListResponse)
    func saveCurrentRate(response: CurrencyLiveResponse)
    func getSavedInformation<T: Decodable>() -> T?
}
