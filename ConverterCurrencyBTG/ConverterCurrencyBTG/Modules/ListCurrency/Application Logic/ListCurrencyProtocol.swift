//
//  ListCurrencyProtocol.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation

protocol ListCurrencyPresenterInput {
    func viewDidLoad()
}

protocol ListCurrencyPresenterOuput: class {
    func loadView(viewModels: [ListViewModel])
}
protocol ListCurrencyInteractorInput {
    func loadData()
}

protocol ListCurrencyInteractorOuput: class {
    func fetched(entites: [HomeEntity])
}
