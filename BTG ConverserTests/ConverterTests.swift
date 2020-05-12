//
//  ConverterTests.swift
//  BTG ConverserTests
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import XCTest
@testable import BTG_Converser
import RealmSwift

class ConverterTests: XCTestCase {

    override func setUpWithError() throws {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "testing-db"
        sleep(1)
    }

}

extension ConverterTests {

    func testConverterValueFromSameCode() throws {

        let fromCode = "fake"
        let toCode = "fake"

        let converter = CurrencyConverter(fromCode: fromCode, toCode: toCode)

        let valueToConvert = Double(51)
        let expectedValue = valueToConvert

        XCTAssertEqual(converter.convertValue(valueToConvert), expectedValue)
    }

    func testConverterValueDirect() throws {
        let fromCode = "fake"
        let toCode = "news"
        let valueTax = Double(5)

        TaxModel.createOrUpdate(fromCode: fromCode, toCode: toCode, value: valueTax)

        let converter = CurrencyConverter(fromCode: fromCode, toCode: toCode)

        let valueToConvert = Double(51)
        let expectedValue = valueToConvert * valueTax

        XCTAssertEqual(converter.convertValue(valueToConvert), expectedValue)
    }


    func testConverterValueDirectReverse() throws {
        let fromCode = "fake"
        let toCode = "news"
        let valueTax = Double(5)

        TaxModel.createOrUpdate(fromCode: toCode, toCode: fromCode, value: valueTax)

        let converter = CurrencyConverter(fromCode: fromCode, toCode: toCode)

        let valueToConvert = Double(51)
        let expectedValue = valueToConvert / valueTax

        XCTAssertEqual(converter.convertValue(valueToConvert), expectedValue)
    }

    func testConverterValueIndirect() throws {
        let fromCode = "fake"

        let valueTaxDefaultToFrom = Double(5)

        TaxModel.createOrUpdate(
            fromCode: CurrencyConverter.defaultCurrencyCode,
            toCode: fromCode,
            value: valueTaxDefaultToFrom
        )

        let toCode = "news"
        let valueTaxDefaultToTo = Double(3)

        TaxModel.createOrUpdate(
            fromCode: CurrencyConverter.defaultCurrencyCode,
            toCode: toCode,
            value: valueTaxDefaultToTo
        )

        let converter = CurrencyConverter(fromCode: fromCode, toCode: toCode)

        let valueToConvert = Double(51)
        let expectedValue = valueToConvert / valueTaxDefaultToFrom * valueTaxDefaultToTo

        XCTAssertEqual(converter.convertValue(valueToConvert), expectedValue)
    }

}
