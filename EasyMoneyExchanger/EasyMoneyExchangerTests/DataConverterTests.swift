//
//  EasyMoneyExchangerTests.swift
//  EasyMoneyExchangerTests
//
//  Created by Leon on 07/12/20.
//

import XCTest
@testable import EasyMoneyExchanger

class DataConverterTestsTests: XCTestCase {

    let supportedCurrencies = SupportedCurrenciesViewModel(coreData: CoreDataManager())

    func testGetSupportedList() {
        let dictionary = [ "USD": "United States Dollar", "BRL": "Brazilian Real"]
        let result = supportedCurrencies.getSupportedList(supportedDictionary: dictionary)
        XCTAssert(result[0].currencyCode == "BRL" && result[0].currencyName == "Brazilian Real", "Supported List Operation Failed" )
    }

    func testSortSupportedList() {
        let list = [SupportedList(currencyCode: "USD", currencyName: "United States Dollar"), SupportedList(currencyCode: "BRL", currencyName: "Brazilian Real")]
        let result = supportedCurrencies.sortSupportedList(supportedList: list)
        XCTAssert(result[0].currencyCode == "BRL" && result[0].currencyName == "Brazilian Real", "Supported List Operation Failed" )
    }

    func testAddSupportedListFlags() {
        let list = [SupportedList(currencyCode: "USD", currencyName: "United States Dollar"), SupportedList(currencyCode: "BRL", currencyName: "Brazilian Real")]
        let result = supportedCurrencies.addSupportedListFlags(supportedList: list)
        XCTAssert(result[0].currencyCode == "USD" && result[0].currencyName == "🇺🇸 United States Dollar", "Supported List Operation Failed" )
    }

    func testGetStringFirstCharacter() {
        let list = "Brazilian Real"
        let result = supportedCurrencies.getStringFirstCharacter(string: list)
        XCTAssert(result == "B", "Supported List Operation Failed" )
    }

    func testGetSupportedTitles() {
        let list = [SupportedList(currencyCode: "USD", currencyName: "United States Dollar"), SupportedList(currencyCode: "BRL", currencyName: "Brazilian Real")]
        let result = supportedCurrencies.getSupportedTitles(supportedList: list)
        XCTAssert(result == ["B", "U"], "Supported List Operation Failed" )
    }
}
