//
//  ListTests.swift
//  BTG ConverserTests
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import XCTest
@testable import BTG_Converser
import CoreData

class ListTests: XCTestCase {

    var presenter: ListPresenter!
    var viewToPresenter = ListViewToPresenterTest()

    override func setUpWithError() throws {
        super.setUp()
        Database.currentContext = setUpInMemoryManagedObjectContext()
        self.presenter = ListPresenter(view: viewToPresenter)
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

extension ListTests {

    func testGetAllListItems() throws {
        let expectation = self.expectation(description: "Get all elements")

        let expectedCode1 = "a"
        _ = CurrencyModel.createOrUpdate(code: expectedCode1, name: "foo")

        let expectedCode2 = "b"
        _ = CurrencyModel.createOrUpdate(code: expectedCode2, name: "bar")

        self.viewToPresenter.updateListItemsCompletion = { listItems in
            XCTAssertEqual(listItems.count, 2)
            XCTAssertNotNil(listItems.first(where: { $0.code == expectedCode1 }))
            XCTAssertNotNil(listItems.first(where: { $0.code == expectedCode2 }))
            expectation.fulfill()
        }

        self.presenter.viewDidLoad()

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetAllListItemsOrderByCodeAsc() throws {
        let expectation = self.expectation(description: "Get all elements")

        let expectedCodeA = "a"
        _ = CurrencyModel.createOrUpdate(code: expectedCodeA, name: "foo")

        let expectedCodeB = "b"
        _ = CurrencyModel.createOrUpdate(code: expectedCodeB, name: "bar")

        self.viewToPresenter.updateListItemsCompletion = { listItems in
            XCTAssertEqual(listItems[0].code, expectedCodeA)
            XCTAssertEqual(listItems[1].code, expectedCodeB)
            expectation.fulfill()
        }

        self.presenter.viewDidLoad()

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetAllListItemsOrderByCodeDesc() throws {
        let expectation = self.expectation(description: "Get all elements")

        let expectedCodeA = "a"
        _ = CurrencyModel.createOrUpdate(code: expectedCodeA, name: "for")

        let expectedCodeB = "b"
        _ = CurrencyModel.createOrUpdate(code: expectedCodeB, name: "bar")

        self.presenter.viewDidLoad()

        self.viewToPresenter.updateListItemsCompletion = { listItems in
            XCTAssertEqual(listItems[1].code, expectedCodeA)
            XCTAssertEqual(listItems[0].code, expectedCodeB)
            expectation.fulfill()
        }

        self.presenter.sortByCodeTapped()

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetAllListItemsOrderByNameAsc() throws {
        let expectation = self.expectation(description: "Get all elements")

        let expectedNameA = "2"
        _ = CurrencyModel.createOrUpdate(code: "foo", name: expectedNameA)

        let expectedNameB = "1"
        _ = CurrencyModel.createOrUpdate(code: "bar", name: expectedNameB)

        self.presenter.viewDidLoad()

        self.viewToPresenter.updateListItemsCompletion = { listItems in
            XCTAssertEqual(listItems[0].name, expectedNameA)
            XCTAssertEqual(listItems[1].name, expectedNameB)
            expectation.fulfill()
        }

        self.presenter.sortByNameTapped()

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetAllListItemsOrderByNameDesc() throws {
        let expectation = self.expectation(description: "Get all elements")

        let expectedNameA = "2"
        _ = CurrencyModel.createOrUpdate(code: "foo", name: expectedNameA)

        let expectedNameB = "1"
        _ = CurrencyModel.createOrUpdate(code: "bar", name: expectedNameB)

        self.presenter.viewDidLoad()
        self.presenter.sortByNameTapped()

        self.viewToPresenter.updateListItemsCompletion = { listItems in
            XCTAssertEqual(listItems[1].name, expectedNameA)
            XCTAssertEqual(listItems[0].name, expectedNameB)
            expectation.fulfill()
        }

        self.presenter.sortByNameTapped()

        waitForExpectations(timeout: 5, handler: nil)
    }

}


extension ListTests {

    class ListViewToPresenterTest: ListViewToPresenter {

        var updateListItemsCompletion: ((_ listItems: [ListItem]) -> ())?
        func updateListItems(_ listItems: [ListItem]) {
            updateListItemsCompletion?(listItems)
        }

        var showStateSortByCodeAscCompletion: (() -> ())?
        func showStateSortByCodeAsc() {
            showStateSortByCodeAscCompletion?()
        }

        var showStateSortByCodeDescCompletion: (() -> ())?
        func showStateSortByCodeDesc() {
            showStateSortByCodeDescCompletion?()
        }

        var showStateSortByNameAscCompletion: (() -> ())?
        func showStateSortByNameAsc() {
            showStateSortByNameAscCompletion?()
        }

        var showStateSortByNameDescCompletion: (() -> ())?
        func showStateSortByNameDesc() {
            showStateSortByNameDescCompletion?()
        }

    }
}
