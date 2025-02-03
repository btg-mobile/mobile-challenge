//
//  ConversionVMTests.swift
//  Mobile Challenge
//
//  Created by Vinicius Serpa on 20/11/24.
//

import XCTest
@testable import Mobile_Challenge

class ConversionVMTests: XCTestCase {

    var conversionViewModel: ConversionViewModel!

    override func setUp() {
        super.setUp()
        conversionViewModel = ConversionViewModel()
    }

    override func tearDown() {
        conversionViewModel = nil
        super.tearDown()
    }
    
    func testConversionCalculation() {
        let currency = ConversionModel(code: "USD", dolarValue: 5.0)
        conversionViewModel.convertions.append(currency)

        let selectedCurrency = conversionViewModel.convertions.first(where: { $0.code == "USD" })
        
        XCTAssertEqual(selectedCurrency?.dolarValue, 5.0, "Dolar igual a 5.0")
    }
}
