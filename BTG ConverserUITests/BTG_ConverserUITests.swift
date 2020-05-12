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

        expectation(for: NSPredicate(format: "count > 0"), evaluatedWith: app.tables.cells, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)

        let thirdCell = app.tables.firstMatch.cells.element(boundBy: 3)
        let fromCode = thirdCell.staticTexts.firstMatch.label.prefix(3).description

        thirdCell.tap()

        let fromCodeLabel = app.staticTexts["From Code"]
        let fromInput = app.textFields["From Input"]

        expectation(for: NSPredicate(format: "exists == true"), evaluatedWith: fromCodeLabel, handler: nil)
        expectation(for: NSPredicate(format: "label == %@", fromCode), evaluatedWith: fromCodeLabel, handler: nil)
        expectation(for: NSPredicate(format: "isEnabled == true"), evaluatedWith: fromInput, handler: nil)

        waitForExpectations(timeout: 3, handler: nil)
    }

    func testSelectToCode() throws {
        let app = XCUIApplication()

        app.launch()
        app.buttons["to"].tap()

        expectation(for: NSPredicate(format: "count > 0"), evaluatedWith: app.tables.cells, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)

        let fifth = app.tables.firstMatch.cells.element(boundBy: 5)
        let toCode = fifth.staticTexts.firstMatch.label.prefix(3).description

        fifth.tap()

        let toLabel = app.staticTexts["Convert Value"]

        expectation(for: NSPredicate(format: "exists == true"), evaluatedWith: toLabel, handler: nil)
        expectation(for: NSPredicate(format: "label == %@", toCode), evaluatedWith: toLabel, handler: nil)

        waitForExpectations(timeout: 3, handler: nil)
    }

    func testInputAcceptOnlyDecimalNumber() throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["from"].tap()

        expectation(for: NSPredicate(format: "count > 0"), evaluatedWith: app.tables.cells, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)

        app.tables.cells.element(boundBy: 3).tap()

        app.buttons["to"].tap()

        expectation(for: NSPredicate(format: "count > 0"), evaluatedWith: app.tables.cells, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)

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

        expectation(for: NSPredicate(format: "count > 0"), evaluatedWith: app.tables.cells, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)

        app.tables.cells.element(boundBy: 3).tap()

        app.buttons["to"].tap()

        expectation(for: NSPredicate(format: "count > 0"), evaluatedWith: app.tables.cells, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)

        let fifthCurrency = app.tables.firstMatch.cells.element(boundBy: 5)
        let toCode = fifthCurrency.staticTexts.firstMatch.label.prefix(3).description

        fifthCurrency.tap()

        let toLabel = app.staticTexts["Convert Value"]

        expectation(for: NSPredicate(format: "exists == true"), evaluatedWith: toLabel, handler: nil)
        expectation(for: NSPredicate(format: "label == %@", toCode), evaluatedWith: toLabel, handler: nil)
        waitForExpectations(timeout: 3, handler: nil)

        let fromInput = app.textFields["From Input"]

        fromInput.tap()
        fromInput.typeText("21.17")

        app.buttons["CONVERT"].tap()

        expectation(for: NSPredicate(format: "label != %@", toCode), evaluatedWith: toLabel, handler: nil)

        waitForExpectations(timeout: 3, handler: nil)

        XCTAssertTrue(toLabel.label.contains(toCode))
    }

}
