//
//  Coin_ConverterTests.swift
//  Coin ConverterTests
//
//  Created by Igor Custodio on 27/07/21.
//

import XCTest
@testable import Coin_Converter

class HomeViewModelTests: XCTestCase {

    func testShouldMakeValidUrl() {
        var route = ApiRoute.list
        XCTAssertNoThrow(try route.getUrl(apiBase: Environment.shared.variable(.apiBaseUrl)))
        route = .live
        XCTAssertNoThrow(try route.getUrl(apiBase: Environment.shared.variable(.apiBaseUrl)))
    }
}

extension HomeViewModelTests {
    func makeSut() -> HomeViewModel {
        let viewModel = HomeViewModel(service: ServiceSpy())
        
        return viewModel
    }
}

class ServiceSpy: ServiceProtocol {
    func request(route: ApiRoute, completion: @escaping (Result) -> ()) {
        
    }
}
