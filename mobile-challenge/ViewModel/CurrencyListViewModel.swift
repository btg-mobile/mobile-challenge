//
//  CurrencyListViewModel.swift
//  mobile-challenge
//
//  Created by Brunno Andrade on 04/10/20.
//

import Foundation

class CurrencyListViewModel {
    
    let title: String = "Listagem de Moedas"
    var typeConverter: TypeConverter
    var currencies: [Currency] = []
    
    init(type: TypeConverter) {
        self.typeConverter = type
    }
    
}
