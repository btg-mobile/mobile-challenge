//
//  InitialViewModelTest.swift
//  BTGmobile-challengeTests
//
//  Created by Cassia Aparecida Barbosa on 14/10/20.
//

import XCTest
@testable import BTGmobile_challenge

class InitialViewModelTest: XCTestCase {

	var sut: InitialViewModel!
	
	var navigation: UINavigationController =  UINavigationController(nibName: nil, bundle: nil)
	
	override func setUp() {
		super.setUp()
		sut = InitialViewModel(coordinator: CurrencyCoordinator(navigationController: navigation))
		
	}
	
	func testInitialAmount () {
		XCTAssertEqual(sut.initialAmount, "")
	}
	func testConverteFromDolar() {
		XCTAssertEqual(sut.converteFromDolar(currencies: sut.liveCurrencies, currency: "BRL"), 5.0 )
	}
	func testConversion() {
		XCTAssertEqual(sut.converte(firstCurrency: 5.0, secondCurrency: 2.0, amount: 2.5), 1.0)
	}
	
	
	override func tearDown() {
		super.tearDown()
		sut = nil
	}
}
