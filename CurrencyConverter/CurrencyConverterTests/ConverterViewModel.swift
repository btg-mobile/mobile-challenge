//
//  ConverterViewModel.swift
//  CurrencyConverterTests
//
//  Created by Breno Aquino on 29/10/20.
//

import XCTest
@testable import CurrencyConverter

class ConverterViewModelTests: XCTestCase {

    func testTextValueFormmaterNil() throws {
        let viewModel = ConverterViewModel()
        XCTAssert(viewModel.textValueFomatter(nil) == "")
    }
    
    func testTextValueFormmaterEmpty() throws {
        let viewModel = ConverterViewModel()
        XCTAssert(viewModel.textValueFomatter("") == "")
    }
    
    func testTextValueFormmaterLetters() throws {
        let viewModel = ConverterViewModel()
        XCTAssert(viewModel.textValueFomatter("asdasdasd") == "")
    }
    
    func testTextValueFormmaterNumbersWithComma() throws {
        let viewModel = ConverterViewModel()
        XCTAssert(viewModel.textValueFomatter("456,12") == "456.12")
    }
    
    func testTextValueFormmaterNumbersWithDot() throws {
        let viewModel = ConverterViewModel()
        XCTAssert(viewModel.textValueFomatter("456.12") == "456.12")
    }
    
    func testTextValueFormmaterOnlyCents() throws {
        let viewModel = ConverterViewModel()
        XCTAssert(viewModel.textValueFomatter("56") == "0.56")
    }
    
    func testTextValueFormmaterCentsWithUnit() throws {
        let viewModel = ConverterViewModel()
        XCTAssert(viewModel.textValueFomatter("3456") == "34.56")
    }
    
    func testTextValueFormmaterBigNumber() throws {
        let viewModel = ConverterViewModel()
        XCTAssert(viewModel.textValueFomatter("4562312351") == "45623123.51")
    }
}
