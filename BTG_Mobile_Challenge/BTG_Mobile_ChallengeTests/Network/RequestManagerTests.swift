//
//  RequestManagerTests.swift
//  BTG_Mobile_ChallengeTests
//
//  Created by Pedro Henrique Guedes Silveira on 19/12/20.
//

import XCTest
@testable import BTG_Mobile_Challenge

class RequestManagerTests: XCTestCase {
    
    var service: ServiceMock!
    var sut: RequestManager!
    
    override func setUpWithError() throws {
        super.setUp()
        let bundle = Bundle(for: type(of: self))
        service = ServiceMock(bundle: bundle)
        sut = RequestManager()
    }
    
    func testPerfomLiveCurrency() {
        
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
