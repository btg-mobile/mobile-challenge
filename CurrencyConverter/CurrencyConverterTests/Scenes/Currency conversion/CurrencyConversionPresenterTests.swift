//
//  CurrencyConversionPresenterTests.swift
//  CurrencyConverterTests
//
//  Created by Tiago Chaves on 10/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//
@testable import CurrencyConverter
import XCTest

class CurrencyConversionPresenterTests: XCTestCase {

    var sut: CurrencyConversionPresenter!
    
    override func setUp() {
        super.setUp()
        sut = CurrencyConversionPresenter()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    final class ViewControllerSpy: CurrencyConversionDisplayLogic {
        var loadSupportedCurrenciesCalled = false
        var displayErrorMessageCalled = false
        
        var supportedCurrenciesViewModel: CurrencyConversion.LoadSupportedCurrencies.ViewModel!
        
        func loadSupportedCurrencies(viewModel: CurrencyConversion.LoadSupportedCurrencies.ViewModel) {
            loadSupportedCurrenciesCalled = true
            supportedCurrenciesViewModel = viewModel
        }
        
        func displayErrorMessage(_ message: String) {
            displayErrorMessageCalled = true
        }
    }
    
    func testPresenter_whenReceiveError_isCallingDisplayErrorMessageFromViewController() {
        let viewControllerSpy = ViewControllerSpy()
        sut.viewController = viewControllerSpy
        let response = CurrencyConversion.LoadSupportedCurrencies.Response(currencies: nil, error: NetworkSupportedCurrenciesWorkerError.requestError)
        
        sut.formatCurrencyListForView(response: response)
        
        XCTAssertTrue(viewControllerSpy.displayErrorMessageCalled)
    }
    
    func testPresenter_whenReceiveSuccessFalse_isCallingDisplayErrorMessageFromViewController() {
        let viewControllerSpy = ViewControllerSpy()
        sut.viewController = viewControllerSpy
        let response = CurrencyConversion.LoadSupportedCurrencies.Response(currencies: Seeds.APISeeds.supportedCurrenciesAPIError, error: nil)
        
        sut.formatCurrencyListForView(response: response)
        
        XCTAssertTrue(viewControllerSpy.displayErrorMessageCalled)
    }
    
    func testPresenter_isCallingLoadSupportedCurrenciesFromViewController() {
        let viewControllerSpy = ViewControllerSpy()
        sut.viewController = viewControllerSpy
        let response = CurrencyConversion.LoadSupportedCurrencies.Response(currencies: Seeds.APISeeds.supportedCurrencies, error: nil)
        
        sut.formatCurrencyListForView(response: response)
        
        XCTAssertTrue(viewControllerSpy.loadSupportedCurrenciesCalled)
    }
    
    func testPresenter_isSendingCorrenctListOfCurrenciesToViewController() {
        let viewControllerSpy = ViewControllerSpy()
        sut.viewController = viewControllerSpy
        let response = CurrencyConversion.LoadSupportedCurrencies.Response(currencies: Seeds.APISeeds.supportedCurrencies, error: nil)
        let expectedResult = Seeds.ViewModels.viewModelCurrencies.sorted(by: >)
        
        sut.formatCurrencyListForView(response: response)
        
        XCTAssertEqual(expectedResult, viewControllerSpy.supportedCurrenciesViewModel.currencies.sorted(by: >))
    }
}
