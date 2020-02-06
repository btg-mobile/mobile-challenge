//
//  CurrencyListViewModel.swift
//  BTGTesteChallenge
//
//  Created by Rafael  Hieda on 2/6/20.
//  Copyright © 2020 Rafael_Hieda. All rights reserved.
//

import Foundation

protocol ListOfCurrencyViewModelProtocol: class {
    var listCurrencyRepository: ListCurrencyRepositoryProtocol? { get }
    func requestLoadData()
}

class ListOfCurrencyViewModel: ListOfCurrencyViewModelProtocol {
    func requestLoadData() {

    }

    weak var listCurrencyRepository: ListCurrencyRepositoryProtocol?

    init(listCurrencyRepository: ListCurrencyRepositoryProtocol) {
        self.listCurrencyRepository = listCurrencyRepository
    }
}
