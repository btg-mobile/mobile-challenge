//
//  CurrencyConversionInteractorTests.swift
//  CurrencyConverterTests
//
//  Created by Tiago Chaves on 10/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//
@testable import CurrencyConverter
import XCTest

class CurrencyConversionInteractorTests: XCTestCase {
    var sut: CurrencyConversionInteractor!
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    private func initSutWithError() {
        sut = CurrencyConversionInteractor(supportedCurrenciesWorker: NetworkSupportedCurrenciesWorkerMock(returnError: NetworkSupportedCurrenciesWorkerError.requestError),
                                           exchangeRatesWorker: NetworkExchangeRatesWorkerMock(returnError: NetworkExchangeRatesWorkerError.requestError))
    }
    
    private func initSut() {
        sut = CurrencyConversionInteractor(supportedCurrenciesWorker: NetworkSupportedCurrenciesWorkerMock(),
                                           exchangeRatesWorker: NetworkExchangeRatesWorkerMock())
    }
    
    final class CurrencyConversionPresenterSpy: CurrencyConversionPresentationLogic {
        var formatCurrencyListCalled = false
        var getExchangeRatesFailedCalled = false
        var formatCurrencyListResponse: CurrencyConversion.LoadSupportedCurrencies.Response!
        
        func formatCurrencyListForView(response: CurrencyConversion.LoadSupportedCurrencies.Response) {
            formatCurrencyListCalled = true
            formatCurrencyListResponse = response
        }
        
        func getExchangeRatesFailed() {
            getExchangeRatesFailedCalled = true
        }
    }
    
    func testInteractor_afterRunGetSupportedCurrencies_isCallingFormatCurrencyListFromPresenter() {
        initSut()
        let presenterSpy = CurrencyConversionPresenterSpy()
        sut.presenter = presenterSpy
        
        sut.getSupportedCurrencies()
        
        XCTAssertTrue(presenterSpy.formatCurrencyListCalled)
    }
    
    func testInteractor_afterRunGetExchangeRates_isSettingTheExchangeRatesVar() {
        initSut()
        
        sut.getExchangeRates()
        
        XCTAssertEqual(Seeds.APISeeds.exchangeRates, sut.exchangeRates)
    }
    
    func testInteractor_whenGetSupportedCurrenciesReturnError_isSendingTheErrorToPresenter() {
        initSutWithError()
        let presenterSpy = CurrencyConversionPresenterSpy()
        sut.presenter = presenterSpy
        
        sut.getSupportedCurrencies()
        
        XCTAssertNotNil(presenterSpy.formatCurrencyListResponse.error)
    }
    
    func testInteractor_whenGetExchangeRatesReturnError_isCallingGetErrorExchangeFailedFromPresenter() {
        initSutWithError()
        let presenterSpy = CurrencyConversionPresenterSpy()
        sut.presenter = presenterSpy
        
        sut.getExchangeRates()
        
        XCTAssertTrue(presenterSpy.getExchangeRatesFailedCalled)
    }
    
    func testInteractor_afterRunGetSupportedCurrencies_isSendingTheSupportedCurrenciesToPresenter() {
        initSut()
        let presenterSpy = CurrencyConversionPresenterSpy()
        sut.presenter = presenterSpy
        let expectedResult = Seeds.APISeeds.supportedCurrencies
        
        sut.getSupportedCurrencies()
        
        XCTAssertEqual(expectedResult, presenterSpy.formatCurrencyListResponse.currencies)
    }
}
