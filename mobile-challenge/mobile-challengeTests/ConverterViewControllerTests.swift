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
        let expectedError: ValidationError = .inputIsNil
        var testError: ValidationError?
        
        do {
            try viewController.inputValidator(nil)
        } catch {
            testError = error as? ValidationError
        }
        
        XCTAssertEqual(expectedError, testError)
    }
    
    func testInputValueIsEmpty() {
        let expectedError: ValidationError = .inputIsEmpty
        var testError: ValidationError?
        
        do {
            try viewController.inputValidator("")
        } catch {
            testError = error as? ValidationError
        }
        
        XCTAssertEqual(expectedError, testError)
    }
    
    func testInputValueIsInvalid() {
        let expectedError: ValidationError = .inputIsNotDouble
        var testError: ValidationError?
        
        do {
            try viewController.inputValidator("1.2.")
        } catch {
            testError = error as? ValidationError
        }
        
        XCTAssertEqual(expectedError, testError)
    }
    
    func testInputValueFormatContainsComma() {
        let expectedError: ValidationError? = nil
        var testError: ValidationError?
        
        do {
            try viewController.inputValidator("1,2")
        } catch {
            testError = error as? ValidationError
        }
        
        XCTAssertEqual(expectedError, testError)
    }
    
    func testInputValueIsNegative() {
        let expectedError: ValidationError? = .valueIsNegative
        var testError: ValidationError?
        
        do {
            try viewController.inputValidator("-1,2")
        } catch {
            testError = error as? ValidationError
        }
        
        XCTAssertEqual(expectedError, testError)
    }
    
}
