//
//  convertMoneysTests.swift
//  convertMoneysTests
//
//  Created by Mateus Rodrigues Santos on 25/11/20.
//

import XCTest
@testable import convertMoneys

class convertMoneysTests: XCTestCase {
    
    let sut = ConvertViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testConvert() throws {
        //ARS
        sut.atualQuoteDestiny = 80.89
        //BRL
        sut.atualQuoteOrigin = 5.31
        
        let result = try sut.convert(valueForConvertion: 2, nameCurrencyOrigin: "BRL", nameCurrencyDestny: "ARS")
        
        XCTAssertEqual(30.46, result)
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

}
