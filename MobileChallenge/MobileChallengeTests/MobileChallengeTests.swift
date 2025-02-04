//
//  MobileChallengeTests.swift
//  MobileChallengeTests
//
//  Created by Gabriel Vicentin Negro on 18/11/24.
//

import XCTest
import Combine
@testable import MobileChallenge

final class MobileChallengeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAPIRequestLiveValue() async {
        let viewModel = LiveValueViewModel()
        let expectation = XCTestExpectation(description: "Lista de valores deve ser atualizada")
        var cancellables = Set<AnyCancellable>()
        
        viewModel.$liveValuesList
            .dropFirst()
            .sink { liveValues in
                print("chegou algo \(liveValues)")
                XCTAssertFalse(liveValues.isEmpty, "A lista de valores não deve estar vazia")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.getLiveValues()
        await fulfillment(of: [expectation], timeout: 10.0)
    }

    func testAPICurrencyList() async {
        let viewModel = ListOfCurrencyViewModel()
        let expectation = XCTestExpectation(description: "Lista de currencies deve ser atualizada")
        var cancellables = Set<AnyCancellable>()
        
        viewModel.$currencies
            .dropFirst()
            .sink { currencies in
                XCTAssertFalse(currencies.isEmpty, "A lista de currencies não deve estar vazia")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.getListOfCurrency()
        await fulfillment(of: [expectation], timeout: 10.0)
    }
    
    func testCalculation() {
        let viewModel = LiveValueViewModel()
        let originalValue: Double = 5
        
        let result = viewModel.calculate(originalValue: originalValue, multiplier: 5)
        XCTAssertEqual(result, "25.00")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
