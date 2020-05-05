//
//  StorageTests.swift
//  StorageTests
//
//  Created by Gustavo Amaral on 03/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import XCTest
import Service
import Models
import Combine
@testable import Storage

fileprivate let testCurrencies = [
    Currency(abbreviation: "AED", fullName: "United Arab Emirates Dirham"),
    Currency(abbreviation: "AFN", fullName: "Afghan Afghani"),
    Currency(abbreviation: "ALL", fullName: "Albanian Lek"),
    Currency(abbreviation: "AMD", fullName: "Armenian Dram"),
    Currency(abbreviation: "ANG", fullName: "Netherlands Antillean Guilder")
].sorted()

fileprivate let testQuotes = [
    Quote("USD", "AUD", 1.278342),
    Quote("USD", "EUR", 1.278342),
    Quote("USD", "GBP", 0.908019),
    Quote("USD", "PLN", 3.731504)
].sorted()

class StorageTestsWithSQLiteStorage: XCTestCase {

    override func setUp() {
        let services = Services.default
        services.register(Storage.self) { SQLiteStorage(.inMemory) }
    }
    
    func testWritingAndReadingCurrenciesBack() {
        let storage: Storage = Services.default.make(for: Storage.self)
        let expectation = self.expectation(description: "Wait write and read")
        _ = storage.write(testCurrencies)
            .flatMap { currencies -> AnyPublisher<[Row<Currency>], StorageError> in storage.read() }
            .map { $0.map { $0.model } }
            .sink(receiveCompletion: { completion in }) { currencies in
                XCTAssert(testCurrencies == currencies.sorted(), "Read currencies aren't equal to the written.")
                expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 0.1)
    }
    
    func testWritingAndReadingQuotesBack() {
        let storage: Storage = Services.default.make(for: Storage.self)
        let expectation = self.expectation(description: "Wait write and read")
        _ = storage.write(testQuotes)
            .flatMap { quotes -> AnyPublisher<[Row<Quote>], StorageError> in storage.read() }
            .map { $0.map { $0.model } }
            .sink(receiveCompletion: { completion in }) { quotes in
                XCTAssert(testQuotes == quotes.sorted(), "Read quotes aren't equal to the written.")
                expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 0.1)
    }

}
