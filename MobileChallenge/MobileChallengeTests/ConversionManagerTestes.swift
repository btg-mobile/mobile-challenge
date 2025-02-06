//
//  ConversionManagerTestes.swift
//  MobileChallengeTests
//
//  Created by Giovanna Bonifacho on 06/02/25.
//

import Foundation
import XCTest

@testable import MobileChallenge

class ConversionManagerTestes: XCTestCase {
    var conversionManager: ConversionManager!
    var conversionViewModel: ConversionViewModel!
    
    
    override func setUp() async throws {
        try await super.setUp()
        
        let mockNetworkService = MockConversionNetworkService()
        conversionManager = ConversionManager(conversionNetworkService: mockNetworkService)
        conversionViewModel = ConversionViewModel(conversionManager: conversionManager)
    }
    
    func testFetchCurrencyData() async {
        let expectation = self.expectation(description: "fetched conversion data")
        do {
            let data = try await conversionManager.fetchRequest()
            XCTAssertNotNil(data, "should not be nil")
            XCTAssertEqual(data.quotes.count, 5)
            XCTAssertTrue(data.quotes.keys.contains("USDAED"), "USDAED should be a key")
            XCTAssertEqual(data.quotes["USDALL"],  101.4)

            expectation.fulfill()
        } catch {
            XCTFail("Error \(error)")
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        }
    
    func testConvertCurrencyFunc() async{
        let expectation = self.expectation(description: "converted currency")
        do {
            let data = try await conversionManager.fetchRequest()
            let convertedCurrencyContainingUSD = conversionViewModel.converterMoeda(conversionResponse: data, valueToConvert: "38", currencySource: "USD", currencyDestination: "BRL")
            XCTAssertEqual(convertedCurrencyContainingUSD, 201.4)
            let convertedCurrencyWithoutUSD = conversionViewModel.converterMoeda(conversionResponse: data, valueToConvert: "38", currencySource: "EUR", currencyDestination: "BRL")
            XCTAssertEqual(convertedCurrencyWithoutUSD, 251.75)

            expectation.fulfill()

            
        } catch {
            XCTFail("Error \(error)")
        }
        
        wait(for: [expectation], timeout: 5.0)

        
    }
    
    
    }
