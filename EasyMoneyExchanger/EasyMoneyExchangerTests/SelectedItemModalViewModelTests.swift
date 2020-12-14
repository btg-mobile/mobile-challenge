//
//  SelectedItemModalViewModelTests.swift
//  EasyMoneyExchangerTests
//
//  Created by Leon on 14/12/20.
//

import XCTest
@testable import EasyMoneyExchanger

class SelectedItemModalViewModelTests: XCTestCase {
    let selectedItem = SelectItemModalViewModel(coreData: CoreDataManager())

    func testFilterBarList() {
        let list = [SupportedList(currencyCode: "BRL", currencyName: "Brazilian Real"), SupportedList(currencyCode: "USD", currencyName: "United States Dollar")]
        let result = selectedItem.filterSearchbarList(list: list, searchText: "BRL")

        XCTAssert(result[0].currencyName == "Brazilian Real", "Test Failed")
    }
}
