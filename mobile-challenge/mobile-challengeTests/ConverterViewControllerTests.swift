//
//  ConveerterViewControllerTests.swift
//  mobile-challengeTests
//
//  Created by Murilo Teixeira on 26/09/20.
//

import XCTest
@testable import mobile_challenge

class ConverterViewControllerTests: XCTestCase {
    var viewController: ConverterViewController!

    override func setUp() {
        super.setUp()
        viewController = ConverterViewController()
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testInputValueIsNil() {
        let expectedError: InputValueError = .inputIsNil
        var testError: InputValueError?
        
        do {
            try viewController.inputValidator(nil)
        } catch {
            testError = error as? InputValueError
        }
        
        XCTAssertEqual(expectedError, testError)
    }
    
    func testInputValueIsEmpty() {
        let expectedError: InputValueError = .inputIsEmpty
        var testError: InputValueError?
        
        do {
            try viewController.inputValidator("")
        } catch {
            testError = error as? InputValueError
        }
        
        XCTAssertEqual(expectedError, testError)
    }
    
    func testInputValueIsInvalid() {
        let expectedError: InputValueError = .inputIsNotDouble
        var testError: InputValueError?
        
        do {
            try viewController.inputValidator("1.2.")
        } catch {
            testError = error as? InputValueError
        }
        
        XCTAssertEqual(expectedError, testError)
    }
    
    func testInputValueFormatContainsComma() {
        let expectedError: InputValueError? = nil
        var testError: InputValueError?
        
        do {
            try viewController.inputValidator("1,2")
        } catch {
            testError = error as? InputValueError
        }
        
        XCTAssertEqual(expectedError, testError)
    }
    
    func testInputValueIsNegative() {
        let expectedError: InputValueError? = .valueIsNegative
        var testError: InputValueError?
        
        do {
            try viewController.inputValidator("-1,2")
        } catch {
            testError = error as? InputValueError
        }
        
        XCTAssertEqual(expectedError, testError)
    }
    
}
