//
//  BTGConverterAPPTests.swift
//  BTGConverterAPPTests
//
//  Created by Ana Caroline de Souza on 17/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import XCTest
@testable import BTGConverterAPP


class BTGConverterAPPTests: XCTestCase {

    

    func testBaseCurrencytoTargetFormatted() throws {
        
        XCTAssertEqual(BTGCurrencyOperationsController.baseCurrencytoTargetFormatted(baseCurrencyQuantity: 100, to: 10),
                       "$1,000.00")
        XCTAssertEqual(BTGCurrencyOperationsController.baseCurrencytoTargetFormatted(baseCurrencyQuantity: 105, to: 10),
                       "$1,050.00")
        XCTAssertEqual(BTGCurrencyOperationsController.baseCurrencytoTargetFormatted(baseCurrencyQuantity: 1, to: 10),
                       "$10.00")
        XCTAssertEqual(BTGCurrencyOperationsController.baseCurrencytoTargetFormatted(baseCurrencyQuantity: 0.5, to: 10),
                       "$5.00")
        XCTAssertEqual(BTGCurrencyOperationsController.baseCurrencytoTargetFormatted(baseCurrencyQuantity: 1.5, to: 1),
                       "$1.50")
    }



}
