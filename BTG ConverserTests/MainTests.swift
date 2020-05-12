//
//  MainTests.swift
//  BTG ConverserTests
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import XCTest
@testable import BTG_Converser
import RealmSwift

class MainTests: XCTestCase {

    var presenter: MainPresenter!
    var viewToPresenter = MainViewToPresenterTest()

    override func setUpWithError() throws {
        super.setUp()
        self.presenter = MainPresenter(view: viewToPresenter)
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "testing-db"
    }

}

extension MainTests {

    func testFetchAllDataInAPI() throws {
        let expectation = self.expectation(description: "Returns from API")

        self.viewToPresenter.showSuccessStateCompletion = {
            XCTAssertGreaterThan(CurrencyModel.getAll().count, 0)
            expectation.fulfill()
        }

        self.presenter.viewDidLoad()
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testEnableSourceValueInput() throws {
        let expectation = self.expectation(description: "Enable input")

        self.viewToPresenter.toggleEnableSourceTextFieldCompletion = { status in
            XCTAssertTrue(status)
            expectation.fulfill()
        }

        self.presenter.currentEditing = .from
        self.presenter.didSelectCode("foo")

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testEnableConverterButton() throws {
        let expectationNotEnable = self.expectation(description: "Not enable converter button")

        self.viewToPresenter.toggleEnableConverterButtonCompletion = { status in
            debugPrint("first \(status)")
            XCTAssertFalse(status)
            expectationNotEnable.fulfill()
        }

        self.presenter.currentEditing = .from
        self.presenter.didSelectCode("foo")

        waitForExpectations(timeout: 5, handler: nil)

        let expectationEnable = self.expectation(description: "Enable converter button")
        self.viewToPresenter.toggleEnableConverterButtonCompletion = { status in
            debugPrint("second \(status)")
            XCTAssertTrue(status)
            expectationEnable.fulfill()
        }

        self.presenter.currentEditing = .to
        self.presenter.didSelectCode("bar")

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testUpdateSourceCodeLabel() throws {
        let expectation = self.expectation(description: "Update source code")
        let expectedCode = "foo"

        self.viewToPresenter.updateFromCodeCompletion = { code in
            XCTAssertEqual(code, expectedCode)
            expectation.fulfill()
        }

        self.presenter.currentEditing = .from
        self.presenter.didSelectCode(expectedCode)

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testUpdateToValueLabel() throws {
        let expectation = self.expectation(description: "Update to value")
        let expectedValue = "123.000 USD"

        self.presenter.currentEditing = .to
        self.presenter.didSelectCode("USD")

        self.viewToPresenter.updateToValueCompletion = { value in
            XCTAssertEqual(value, expectedValue)
            expectation.fulfill()
        }

        self.presenter.didConvertValue(123)

        waitForExpectations(timeout: 5, handler: nil)
    }

}

extension MainTests {

    final class MainViewToPresenterTest: MainViewToPresenter {

        var valueToConverterText: String? = ""
        var valueToConverter: String? {
            valueToConverterText
        }

        var showWarningFailToUpdateCompletion: ((_ lastUpdateDate: String) ->())?
        func showWarningFailToUpdate(with lastUpdateDate: String) {
            showWarningFailToUpdateCompletion?(lastUpdateDate)
        }

        var showErrorFailToUpdateCompletion: (() ->())?
        func showErrorFailToUpdate() {
            showErrorFailToUpdateCompletion?()
        }

        var showSuccessStateCompletion: (() ->())?
        func showSuccessState() {
            showSuccessStateCompletion?()
        }

        var toggleEnableSourceTextFieldCompletion: ((_ status: Bool) ->())?
        func toggleEnableSourceTextField(to status: Bool) {
            toggleEnableSourceTextFieldCompletion?(status)
        }

        var toggleEnableConverterButtonCompletion: ((_ status: Bool) ->())?
        func toggleEnableConverterButton(to status: Bool) {
            toggleEnableConverterButtonCompletion?(status)
        }

        var updateFromCodeCompletion: ((_ code: String) ->())?
        func updateFromCode(_ code: String) {
            updateFromCodeCompletion?(code)
        }

        var updateToValueCompletion: ((_ value: String) ->())?
        func updateToValue(_ value: String) {
            updateToValueCompletion?(value)
        }

        var showErrorCompletion: ((_ keyMessage: String) ->())?
        func showError(with keyMessage: String) {
            showErrorCompletion?(keyMessage)
        }

    }
}
