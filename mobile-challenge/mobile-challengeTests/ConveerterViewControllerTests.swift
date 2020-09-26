//
//  ConveerterViewControllerTests.swift
//  mobile-challengeTests
//
//  Created by Murilo Teixeira on 26/09/20.
//

import XCTest
@testable import mobile_challenge

class ConverterViewControllerTests: XCTestCase {
    

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testInputValueIsNil() {
        let expectedError: InputValueError = .inputIsNil
        var testError: InputValueError?
        
        do {
            
        } catch {
            
        }
        
        XCTAssertEqual(expectedError, testError)
    }
    
}
