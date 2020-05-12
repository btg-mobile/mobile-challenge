//
//  MainInteractorToPresenter.swift
//  BTG Converser
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

protocol MainInteractorToPresenter: class {

    func fetchTaxesAndCurrenciesInAPI()

    func convertValue(_ value: Double, from fromCode: String, to toCode: String)
}
