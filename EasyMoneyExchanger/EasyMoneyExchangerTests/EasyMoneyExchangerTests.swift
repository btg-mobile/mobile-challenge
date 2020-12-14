//
//  EasyMoneyExchangerTests.swift
//  EasyMoneyExchangerTests
//
//  Created by Leon on 07/12/20.
//

import XCTest
@testable import EasyMoneyExchanger

class EasyMoneyExchangerTests: XCTestCase {

    let supportedCurrencies = SupportedCurrenciesViewModel(coreData: CoreDataManager())

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
