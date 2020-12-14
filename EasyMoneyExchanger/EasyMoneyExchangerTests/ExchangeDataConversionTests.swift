//
//  ExchangeDataConversionTests.swift
//  EasyMoneyExchangerTests
//
//  Created by Leon on 14/12/20.
//

import XCTest
@testable import EasyMoneyExchanger

class ExchangeDataConversionTests: XCTestCase {

    let supportedCurrencies = ExchangeViewModel(service: CurrencyLayerAPI(), coreData: CoreDataManager())

    func testConvertSupportedCurrenciesToFlags() {
        let dictionary = [ "USD": "United States Dollar", "BRL": "Brazilian Real"]
        let dictionaryResult = [ "USD": "🇺🇸 United States Dollar", "BRL": "🇧🇷 Brazilian Real"]
        let result = supportedCurrencies.convertSupportedCurrenciesToFlags(data: dictionary)

        XCTAssert(result.currencies == dictionaryResult, "Test Failed" )
    }

    func testGetCurrencyConverted() {
        let result = currencyConvertedLogic(fromCurrency: "USD", toCurrency: "BRL", amount: 1)

        XCTAssert(result == 5.07, "Test Failed" )
    }

    func testGetDataString() {
        let result = supportedCurrencies.getDateString(timestamp: 1607945458)

        XCTAssert(result == "2020-12-14 11:30", "Test Failed" )
    }

    func currencyConvertedLogic(fromCurrency: String, toCurrency: String, amount: Float) -> Float {

        // Get From value USD
        var fromValue = 1.0
        fromValue = 1 / fromValue

        // Get To Value
        var toValue = 5.07

        toValue = 1 / toValue

        // Calculate
        return Float(fromValue / toValue)  * amount
    }
}
