//
//  ListViewModelTests.swift
//  BTG-CurrencyTests
//
//  Created by Ramon Almeida on 27/10/21.
//

import XCTest
import Combine
@testable import BTG_Currency

class ListViewModelTests: XCTestCase {
    var viewModel: ListViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        viewModel = Container.shared.resolve(ListViewModel.self)!
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testListViewModel_binding() {
        let expectation = XCTestExpectation(description: "HomeService binding test")
        
        viewModel.fetchList()
        
        var list: [ListItem] = []
        
        viewModel.$items
            .dropFirst()
            .sink { receivedList in
                list = receivedList
                expectation.fulfill()
            }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10)
        
        XCTAssert(!list.isEmpty)
    }
}
