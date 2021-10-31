//
//  CurrenciesViewModelTests.swift
//  BTG-CurrencyTests
//
//  Created by Ramon Almeida on 27/10/21.
//

import XCTest
import Combine
@testable import BTG_Currency

class CurrenciesViewModelTests: XCTestCase {
    var viewModel: CurrenciesViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        viewModel = Container.shared.resolve(CurrenciesViewModel.self)!
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
        
        viewModel.listPublisher
            .sink { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("FAILED\nerror: \(error.localizedDescription)")
                case .finished:
                    expectation.fulfill()
                }
            } receiveValue: { receivedList in
                list = receivedList
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10)
        
        XCTAssert(!list.isEmpty)
    }
}
