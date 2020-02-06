//
//  CurrencyConverterViewModelTests.swift
//  BTGTesteChallengeTests
//
//  Created by Rafael  Hieda on 2/5/20.
//  Copyright © 2020 Rafael_Hieda. All rights reserved.
//

import XCTest
@testable import BTGTesteChallenge

class CurrencyConverterViewModelTests: XCTestCase {
    
    var sut: CurrencyConverterViewModelProtocol!
    var currencyRateFilePath: String!
    var currencyListFilepath: String!
    
    override func setUp() {

        let testBundle = Bundle(for: type(of: self))
        currencyRateFilePath = testBundle.path(forResource: "CurrencyRate", ofType: "json")
        currencyListFilepath = testBundle.path(forResource: "CurrencyList", ofType: "json")
        
        sut = CurrencyConverterViewModel(liveCurrencyRepository: DummyLiveCurrencyRepository(), listCurrencyRepository: DummyListCurrencyRepository())
        
        if let data = FileManager().contents(atPath: currencyListFilepath),
            let currencyList = try? JSONDecoder().decode(CurrencyList.self, from: data),
            let currencies = currencyList.currencies {
            sut.currencyDictionary = currencies
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testShouldReturnCurrencyRatesIfValidSelectedSourceAndDestination() {
        sut.selectedSourceCurrency = "ARS"
        sut.selectedConversionCurrency = "ALL"
        if let data = FileManager().contents(atPath: currencyRateFilePath),
            let currencyRate = try? JSONDecoder().decode(CurrencyRate.self, from: data),
            let quotes = currencyRate.quotes {
            sut.currencyRatesDictionary = quotes
        }
        
        XCTAssertNotNil(sut.currencyRatesDictionary)
        XCTAssert(sut.currencyRatesDictionary.count > 0)
        XCTAssertEqual(sut.getUSDCurrencyRateForSource(), 8.901966)
        XCTAssertEqual(sut.getUSDCurrencyRateForDestination(), 126.1652)
        
    }
    
    func testShouldReturnNilCurrencyRatesIfInvalidSelectedSourceAndDestination() {
        sut.selectedSourceCurrency = "xxx"
        sut.selectedConversionCurrency = "xxx"
        
        if let data = FileManager().contents(atPath: currencyRateFilePath),
            let currencyRate = try? JSONDecoder().decode(CurrencyRate.self, from: data),
            let quotes = currencyRate.quotes {
            sut.currencyRatesDictionary = quotes
        }
        
        XCTAssertNotNil(sut.currencyRatesDictionary)
        XCTAssert(sut.currencyRatesDictionary.count > 0)
        XCTAssertEqual(sut.getUSDCurrencyRateForSource(), 0)
        XCTAssertEqual(sut.getUSDCurrencyRateForDestination(), 0)
    }
    
    func testShouldReturnTotalOfCurrencies() {
        XCTAssertNotNil(sut.currencyDictionary)
        XCTAssertTrue(sut.totalOfCurrenciesInList() > 0)
    }
    
    func testShouldReturnKeysIfValidCurrencyList() {
        XCTAssertNotNil(sut.currencyDictionary)
        XCTAssertNotNil(sut.currencyListKey)
        XCTAssertTrue(sut.currencyListKey.count > 0)
    }
    
    func testShouldReturnValuesIfValidCurrencyList() {
        XCTAssertNotNil(sut.currencyDictionary)
        XCTAssertNotNil(sut.currencyListValue)
        XCTAssertTrue(sut.currencyListValue.count > 0)
    }
    
    func testShouldPerformValidConversionIfValidSourceAndDestination() {
        sut.selectedSourceCurrency = "BRL"
        sut.selectedConversionCurrency = "USD"
        let convertedValue = sut.performConversion(value: "20.00")
        XCTAssertTrue(convertedValue > 0)
        XCTAssertEqual(convertedValue, 4.6728972)

    }
}

final class DummyLiveCurrencyRepository : LiveCurrencyRepositoryProtocol {
    var baseURL: String = ""
    var key: String = ""
    var endpoint: Endpoint = .live
    func fetchLiveCurrency(completionHandler: @escaping (Result<CurrencyRate>) -> ()) {}
}

final class DummyListCurrencyRepository: ListCurrencyRepositoryProtocol {
    var baseURL: String = ""
    var key: String = ""
    var endpoint: Endpoint = .list
    func fetchListOfCurrency(completionHandler: @escaping (Result<CurrencyList>) -> ()) {}
}
