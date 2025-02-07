//
//  CurrencyManagerTest.swift
//  MobileChallengeTests
//
//  Created by Giovanna Bonifacho on 06/02/25.
//

import Foundation
import XCTest

@testable import MobileChallenge

class CurrencyManagerTests: XCTestCase {
    var currencyManager: CurrencyManager!
    
    
    override func setUp() async throws {
        try await super.setUp()
        
        let mockNetworkService = MockCurrencyNetworkService()
        currencyManager = CurrencyManager(currencyNetworkService: mockNetworkService)
    }
    
    func testFetchCurrencyData() async {
        let expectation = self.expectation(description: "fetched currency data")
        do {
            let data = try await currencyManager.fetchRequest()
            XCTAssertNotNil(data, "should not be nil")
            XCTAssertEqual(data.currencies.count, 2)
            XCTAssertTrue(data.currencies.keys.contains("USD"), "USD should be a key")
            XCTAssertTrue(data.currencies.keys.contains("EUR"), "EUR should be a key")
            XCTAssertEqual(data.currencies["USD"], "United States Dollar")
            XCTAssertEqual(data.currencies["EUR"], "Euro")

            expectation.fulfill()
        } catch {
            XCTFail("Error \(error)")
        }
        
        wait(for: [expectation], timeout: 5.0)
        }
    }

