//
//  NetworkManagerTests.swift
//  btg-mobile-challengeTests
//
//  Created by Artur Carneiro on 02/10/20.
// swiftlint:disable force_unwrapping
// swiftlint:disable force_try

import XCTest
@testable import btg_mobile_challenge

final class NetworkManagerTests: XCTestCase {

    var service: NetworkServiceMock!
    var sut: NetworkManager!

    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: type(of: self))
        service = NetworkServiceMock(bundle: bundle)
        sut = NetworkManager(service: service)
    }

    func testPerfomLiveCurrencyDecoding() {
        let urlRequest = URLRequest(url: Endpoint.live.url!)
        let stubJSONURL = service.bundle.url(forResource: "live-response", withExtension: "json")
        let stubJSONData = try! Data(contentsOf: stubJSONURL!)

        sut.perform(urlRequest, for: LiveCurrencyReponse.self) { (response) in
            switch response {
            case .success(let result):
                let stubJSON = try! JSONDecoder().decode(LiveCurrencyReponse.self, from: stubJSONData)
                XCTAssertEqual(stubJSON, result)
            case .failure(_):
                XCTFail("Request performed failed.")
            }
        }

    }

    override func tearDown() {
        service = nil
        sut = nil
        super.tearDown()
    }
}
