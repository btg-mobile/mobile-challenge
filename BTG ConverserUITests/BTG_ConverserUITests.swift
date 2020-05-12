//
//  BTG_ConverserUITests.swift
//  BTG ConverserUITests
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 09/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import XCTest

class BTG_ConverserUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testSelectFromCode() throws {
        let app = XCUIApplication()

        app.launch()
        app.buttons["from"].tap()

        XCTAssertTrue(app.tables.cells.firstMatch.waitForExistence(timeout: 10))

        let thirdCell = app.tables.firstMatch.cells.element(boundBy: 3)
        let fromCode = thirdCell.staticTexts.firstMatch.label.prefix(3).description

        thirdCell.tap()

        let fromCodeLabel = app.staticTexts["From Code"]
        let fromInput = app.textFields["From Input"]

        XCTAssertTrue(fromCodeLabel.waitForExistence(timeout: 10))

        XCTAssertEqual(fromCodeLabel.label, fromCode)
        XCTAssertTrue(fromInput.isEnabled)
    }

    func testSelectToCode() throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["to"].tap()
        XCTAssertTrue(app.tables.cells.firstMatch.waitForExistence(timeout: 10))

        let fifth = app.tables.firstMatch.cells.element(boundBy: 5)
        let toCode = fifth.staticTexts.firstMatch.label.prefix(3).description

        fifth.tap()

        let toLabel = app.staticTexts["Convert Value"]

        XCTAssertTrue(toLabel.waitForExistence(timeout: 10))
        XCTAssertEqual(toLabel.label, toCode)
    }

    func testInputAcceptOnlyDecimalNumber() throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["from"].tap()
        XCTAssertTrue(app.tables.cells.firstMatch.waitForExistence(timeout: 10))

        app.tables.cells.element(boundBy: 3).tap()

        app.buttons["to"].tap()
        XCTAssertTrue(app.tables.cells.firstMatch.waitForExistence(timeout: 10))

        app.tables.cells.element(boundBy: 5).tap()

        let fromInput = app.textFields["From Input"]

        fromInput.tap()
        fromInput.typeText("foo")
        fromInput.typeText("15.6")
        fromInput.typeText("bar")
        fromInput.typeText(".444")

        let expectedValue = "15.6444" //The second dot is ignored

        XCTAssertEqual(fromInput.value as! String, expectedValue)
    }

    func testConvertValue() throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["from"].tap()
        XCTAssertTrue(app.tables.cells.firstMatch.waitForExistence(timeout: 10))

        app.tables.cells.element(boundBy: 3).tap()

        app.buttons["to"].tap()
        XCTAssertTrue(app.tables.cells.firstMatch.waitForExistence(timeout: 10))

        let fifthCurrency = app.tables.firstMatch.cells.element(boundBy: 5)
        let toCode = fifthCurrency.staticTexts.firstMatch.label.prefix(3).description

        fifthCurrency.tap()

        let toLabel = app.staticTexts["Convert Value"]

        XCTAssertTrue(toLabel.waitForExistence(timeout: 10))
        XCTAssertEqual(toLabel.label, toCode)

        let fromInput = app.textFields["From Input"]

        fromInput.tap()
        fromInput.typeText("21.17")

        app.buttons["CONVERT"].tap()

        expectation(for: NSPredicate(format: "label != %@", toCode), evaluatedWith: toLabel, handler: nil)

        waitForExpectations(timeout: 3, handler: nil)

        XCTAssertTrue(toLabel.label.contains(toCode))
    }

}
