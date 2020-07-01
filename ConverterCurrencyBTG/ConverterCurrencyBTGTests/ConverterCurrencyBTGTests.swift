//
//  ConverterCurrencyBTGTests.swift
//  ConverterCurrencyBTGTests
//
//  Created by Thiago Vaz on 30/06/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import XCTest
@testable import ConverterCurrencyBTG
import Foundation

class ConverterCurrencyBTGTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let session = URLSession(configuration: .ephemeral)
        session.dataTask(with: URLRequest(url: URL(string: "http://api.currencylayer.com/list?access_key=f2954fa6f49f6af0b3fe2c631cc821a2")!)) { (data, response, error) in
            dump(String(data: data!, encoding: .utf8))
        }.resume()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
