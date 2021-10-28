//
//  HomeViewModelTests.swift
//  BTG-CurrencyTests
//
//  Created by Ramon Almeida on 27/10/21.
//

import XCTest
import Combine
@testable import BTG_Currency

class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        viewModel = Container.shared.resolve(HomeViewModel.self)!
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testListViewModel_binding() {
        let expectation = XCTestExpectation(description: "HomeService binding test")
        
        var outputCurrency: Currency?
        
        viewModel.input = Currency(value: 10.00, symbol: "BRL")
        viewModel.output.symbol = "USD"
        
        viewModel.fetchCurrency()
        
        viewModel.$output
            .dropFirst()
            .sink { receivedCurrency in
                outputCurrency = receivedCurrency
                expectation.fulfill()
            }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10)
        
        XCTAssertNotNil(outputCurrency)
        XCTAssert(outputCurrency!.value  >= 1.87)
    }
    
}
