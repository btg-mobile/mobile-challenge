//
//  HomeProtocol.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation

protocol HomePresenterOutput: class {
    func load(toViewModel: HomeViewModel, fromViewModel: HomeViewModel)
    func converted(sum: String)
}
protocol HomePresenterInput {
    func viewDidLoad()
    func send(toCurrency: String, fromCurrency: String, amount: Decimal)
}

protocol HomeInteractorInput {
    func loadRequest()
    func convert(toCurrency: String, fromCurrency: String, amount: Decimal)
}

protocol HomeInteractorOutput: class {
    func fetched(entites: [HomeEntity])
    func converted(sum: Decimal)
}
