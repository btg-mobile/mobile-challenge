//
//  CurrencyListViewModelTest.swift
//  BTG mobile challangeTests
//
//  Created by Uriel Barbosa Pinheiro on 05/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

@testable import BTG_mobile_challange
import XCTest


class CurrencyListViewModelTest: XCTestCase {

    var sut: CurrencyListViewModel? = nil

    private func setUpSuccessMock() {
        sut = CurrencyListViewModel(servicesProvider: CurrencyListServiceSuccessMock())
    }

    private func setUpErrorMock() {
        sut = CurrencyListViewModel(servicesProvider: CurrencyListServiceErrorMock())
    }

    func testCurrencyListIsNotNil() {
        setUpSuccessMock()
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut?.currencyList)
    }

    func testCurrencyListIsNil() {
        setUpErrorMock()
        XCTAssertNotNil(sut)
        XCTAssertNil(sut?.currencyList)
    }

}
