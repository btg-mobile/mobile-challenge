//
//  ServiceLayerTests.swift
//  BTGProcessoTests
//
//  Created by Lelio Jorge Junior on 07/12/20.
//

import XCTest
@testable import BTGProcesso


class ServiceLayerTests: XCTestCase {

    func test_networkManager() {
        let manager = NetworkManager()
        let stringURl = "http://apilayer.net/api/live?access_key=dde04e1875ba595553125a47e403d12c"
        let url = URL(string: stringURl)!
        XCTAssertNotNil(url)
        manager.request(url: url) { (result: Result<Quota,Error>)in
            let quotes = try! result.get().quotes
            for (key,value) in quotes {
                print(key)
                print(value)
            }
        }
    }
    
    

}
