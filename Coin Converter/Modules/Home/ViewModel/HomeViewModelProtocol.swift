//
//  HomeViewModelProtocol.swift
//  Coin Converter
//
//  Created by Igor Custodio on 27/07/21.
//

import Foundation

protocol HomeViewModelProtocol {
    
    var delegate: HomeViewDelegate? { get set }
    
    func getList()
    func getQuotesList()
    
    func getCurrencies() -> [Currency]
    
    func setSelectedSourceCurrency(currency: Currency)
    func setSelectedTargetCurrency(currency: Currency)
    
    func convertCurrency(value: Double)
    
    func getConversionText() -> String
    func getConvertedValueText() -> String
    
    func getLastUpdatedText() -> String
}
