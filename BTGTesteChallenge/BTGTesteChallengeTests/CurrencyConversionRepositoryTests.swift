//
//  CurrencyConversionRepositoryTests.swift
//  BTGTesteChallengeTests
//
//  Created by Rafael  Hieda on 2/5/20.
//  Copyright © 2020 Rafael_Hieda. All rights reserved.
//

import XCTest
@testable import BTGTesteChallenge

class CurrencyConversionRepositoryTests: XCTestCase {
    
    var sut: LiveCurrencyRepositoryProtocol!

    override func setUp() {
        sut = LiveCurrencyRepository()
        sut.key = "68e904c6ff1193ea810f9a2450e7aaaa"
        sut.baseURL = "http://apilayer.net/api"
        sut.endpoint = .live
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testShouldFetchLiveCurrency() {
        let expectation = XCTestExpectation(description: "expect to fetch data from server")
        sut.fetchLiveCurrency { [weak self] (currencyRate) in
            XCTAssertNotNil(self?.sut.url)
            XCTAssertNotNil(currencyRate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 15)
    }

}
