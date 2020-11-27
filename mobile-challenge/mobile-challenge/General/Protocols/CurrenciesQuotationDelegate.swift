//
//  File.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 27/11/20.
//

import Foundation

protocol CurrenciesQuotationDelegate: class {
    func didFinishFetchQuotations(currenciesQuotation: [CurrencyQuotation])
    func didFinishFetchQuotationsWithError(error: Error)
}
