//
//  HomeEntityMapper.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation

class HomeEntityMapper {
    
    static func mappingListCurrency(listCurrency: ListCurrenciesModel, listQuotes: ListQuotes) -> [HomeEntity] {
        var list = listCurrency.currencies.map({ (key, value) -> HomeEntity in
            return  HomeEntity(name: value, currency: key)

        })
        
        list = list.map({mappingListQuotes(homeEntites: $0, listQuotes: listQuotes)})
        
        return list.sorted{ $0.name < $1.name }
    }
    
    static func mappingListQuotes(homeEntites: HomeEntity, listQuotes: ListQuotes) -> HomeEntity {
        let quote = listQuotes.quotes.first(where: { $0.key == "USD\(homeEntites.currency)"})
        homeEntites.quotes = quote?.value ?? .zero
        return homeEntites
    }
}
