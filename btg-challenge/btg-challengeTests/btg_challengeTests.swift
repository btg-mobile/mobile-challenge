//
//  btg_challengeTests.swift
//  btg-challengeTests
//
//  Created by Wesley Araujo on 13/09/20.
//  Copyright © 2020 Wesley Araujo. All rights reserved.
//

import XCTest
@testable import btg_challenge

class btg_challengeTests: XCTestCase {
    
    func testConvertCurrency() {
        // Given
        let mainViewModel = MainViewModel()
        
        // When
        let convertedValue = mainViewModel.convertCurrency(from: "USDBRL", to: "USDBRL", withValue: 15.0)
        
        // Then
        XCTAssertEqual(15 / ((mainViewModel.live?.quotes!["USDBRL"])!), convertedValue)
    }
    
    func testSelectCurrentQuote() {
        // Given
        let mainViewModel = MainViewModel()
        
        // When
        let currentSourceCurrency = mainViewModel.selectCurrencyQuote(from: "BRL")
        
        // Then
        XCTAssertEqual(currentSourceCurrency, ["USDBRL": 5.31])
    }
    
    func testSelectDestinyCurrency() {
        // Given
        let mainViewModel = MainViewModel()
        
        // When
        let currentDestinyCurrency = mainViewModel.selectDestinyCurrency("BRL")
        
        // Then
        XCTAssertEqual(currentDestinyCurrency, ["USDBRL": 5.31])
    }

}
