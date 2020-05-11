//
//  ConverterTests.swift
//  BTG ConverserTests
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import XCTest
@testable import BTG_Converser
import CoreData

class ConverterTests: XCTestCase {

    override func setUpWithError() throws {
        super.setUp()
        Database.currentContext = setUpInMemoryManagedObjectContext()
    }

    override func tearDownWithError() throws {
        Database.currentContext = setUpInMemoryManagedObjectContext()
    }

    func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!

        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)

        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            print("Adding in-memory persistent store failed")
        }

        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator

        return managedObjectContext
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

        let taxModel = TaxModel.createOrUpdate(fromCode: fromCode, toCode: toCode, value: valueTax)
        XCTAssertNotNil(taxModel)

        let converter = CurrencyConverter(fromCode: fromCode, toCode: toCode)

        let valueToConvert = Double(51)
        let expectedValue = valueToConvert * valueTax

        XCTAssertEqual(converter.convertValue(valueToConvert), expectedValue)
    }


    func testConverterValueDirectReverse() throws {
        let fromCode = "fake"
        let toCode = "news"
        let valueTax = Double(5)

        let taxModel = TaxModel.createOrUpdate(fromCode: toCode, toCode: fromCode, value: valueTax)
        XCTAssertNotNil(taxModel)

        let converter = CurrencyConverter(fromCode: fromCode, toCode: toCode)

        let valueToConvert = Double(51)
        let expectedValue = valueToConvert / valueTax

        XCTAssertEqual(converter.convertValue(valueToConvert), expectedValue)
    }

    func testConverterValueIndirect() throws {
        let fromCode = "fake"

        let valueTaxDefaultToFrom = Double(5)

        let taxModel1 = TaxModel.createOrUpdate(
            fromCode: CurrencyConverter.defaultCurrencyCode,
            toCode: fromCode,
            value: valueTaxDefaultToFrom
        )

        XCTAssertNotNil(taxModel1)

        let toCode = "news"
        let valueTaxDefaultToTo = Double(3)

        let taxModel2 = TaxModel.createOrUpdate(
            fromCode: CurrencyConverter.defaultCurrencyCode,
            toCode: toCode,
            value: valueTaxDefaultToTo
        )

        XCTAssertNotNil(taxModel2)

        let converter = CurrencyConverter(fromCode: fromCode, toCode: toCode)

        let valueToConvert = Double(51)
        let expectedValue = valueToConvert / valueTaxDefaultToFrom * valueTaxDefaultToTo

        XCTAssertEqual(converter.convertValue(valueToConvert), expectedValue)
    }

}
