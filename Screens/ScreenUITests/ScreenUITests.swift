//
//  ScreenUITests.swift
//  ScreenUITests
//
//  Created by Gustavo Amaral on 05/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import XCTest
import Service
import Storage
import Networking

class ScreenUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    override class func setUp() {
        Services.register(Storage.self) { return SQLiteStorage(.inMemory) }
        Services.register(Requester.self) { StaticRequester() }
        Services.register(HomeViewController.self) { HomeToCurrenciesCoordinator() }
    }

    func testSettingCurrencies() throws {
        let app = XCUIApplication()
        app.launch()
        
        let firstCurrency = XCUIApplication().tables.buttons["firstCurrency"].firstMatch
        let firstCoordinate = firstCurrency.coordinate(withNormalizedOffset: .zero)
        firstCoordinate.tap()
        
        let searchBar = XCUIApplication().searchFields.element(boundBy: 0)
        searchBar.tap()
        searchBar.typeText("BRL")
        
        let firstRow = XCUIApplication().tables.cells.element(boundBy: 0)
        firstRow.tap()
        
        let secondCurrency = XCUIApplication().tables.buttons["secondCurrency"].firstMatch
        let secondCoordinate = secondCurrency.coordinate(withNormalizedOffset: .zero)
        secondCoordinate.tap()
        searchBar.tap()
        searchBar.typeText("AED")
        firstRow.tap()
        
        secondCoordinate.tap()
        searchBar.tap()
        searchBar.typeText("AED")
        firstRow.tap()
        
        XCTAssert(firstCurrency.label == "BRL")
        XCTAssert(secondCurrency.label == "AED")
    }
}
