//
//  CurrencyViewModelTests.swift
//  Mobile Challenge
//
//  Created by Vinicius Serpa on 02/02/25.
//

import XCTest
@testable import Mobile_Challenge

class CurrencyVMTests: XCTestCase {

    var currencyViewModel: CurrencyViewModel!

    override func setUp() {
        super.setUp()
        currencyViewModel = CurrencyViewModel()
    }

    override func tearDown() {
        currencyViewModel = nil
        super.tearDown()
    }

    func testNameFetch() {
        let expectation = XCTestExpectation(description: "Sincronizar nome da API")
        
        currencyViewModel.pullCurrencyNames {
            XCTAssertFalse(self.currencyViewModel.currencyNames.isEmpty, "Lista Não Vazia")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}
