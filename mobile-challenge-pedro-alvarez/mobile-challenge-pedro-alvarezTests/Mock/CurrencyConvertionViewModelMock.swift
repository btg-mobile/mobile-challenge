//
//  CurrencyConvertionViewModelMock.swift
//  mobile-challenge-pedro-alvarezTests
//
//  Created by Pedro Alvarez on 28/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

@testable import mobile_challenge_pedro_alvarez
import Foundation

class CurrencyConvertionViewModelMock: CurrencyConversionViewModelProtocol {
    
    var resultValue: NSAttributedString?
    
    var currencyValues: [CurrencyConversionModel] = []
    
    weak var delegate: CurrencyConversionViewModelDelegate?
    
    func fetchCurrencyValues() {

    }
    
    func fetchConvertionResult(value: Double, first: String, second: String) {
        delegate?.didFetchResult(NSAttributedString(string: "1.0"))
    }
}
