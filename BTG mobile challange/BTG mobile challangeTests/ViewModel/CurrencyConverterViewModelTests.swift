//
//  CurrencyConverterViewModelTests.swift
//  BTG mobile challangeTests
//
//  Created by Uriel Barbosa Pinheiro on 03/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

@testable import BTG_mobile_challange
import XCTest


class CurrencyConverterViewModelTests: XCTestCase {

    var sut: CurrencyConverterViewModel? = nil

    private func setUpSuccessMock() {
        sut = CurrencyConverterViewModel(servicesProvider: CurrencyConverterServiceSuccessMock())
    }

    private func setUpErrorMock() {
        sut = CurrencyConverterViewModel(servicesProvider: CurrencyConverterServiceErrorMock())
    }

    func testConvertedValueIsInnitiallyNil() {
        setUpSuccessMock()
        XCTAssertNotNil(sut)
        XCTAssertNil(sut?.convertedValue)
    }

    func testConvertedValueIsNotNilWithValidValues() {
        setUpSuccessMock()
        XCTAssertNotNil(sut)
        sut?.convert(from: "AED", to: "AED", value: 20)
        XCTAssertNotNil(sut?.convertedValue)
        guard let value = sut?.convertedValue else {
            XCTFail("Invalid value")
            return
        }
        XCTAssertEqual(value, 20)
    }

    func testConvertedValueIsNotNilWithValidExchangeValues() {
        setUpSuccessMock()
        XCTAssertNotNil(sut)
        sut?.convert(from: "AED", to: "AFN", value: 20)
        XCTAssertNotNil(sut?.convertedValue)
        guard let value = sut?.convertedValue else {
            XCTFail("Invalid value")
            return
        }
        XCTAssertEqual(value, 418.4681, accuracy: 0.001)
    }

    func testConvertedValueIsNilWhenErrorOccurs() {
        setUpErrorMock()
        XCTAssertNotNil(sut)
        sut?.convert(from: "AED", to: "AFN", value: 20)
        XCTAssertNil(sut?.convertedValue)
    }

}
