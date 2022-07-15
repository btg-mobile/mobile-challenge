//
//  ConversionViewModelTests.swift
//  CurrencyConverterTests
//
//  Created by Joao Jaco Santos Abreu (ACT CONSULTORIA EM TECNOLOGIA LTDA – GEDES – MG) on 15/07/22.
//

import Foundation
@testable import CurrencyConverter
import XCTest

final class ConversionViewModelTests: XCTestCase {
    func testOnInitialCurrencyChange() {
        // given
        let serviceMock = ServiceMock()
        let sut = ConversionViewModel(repository: serviceMock)
        let delegateMock = ConversionViewModelDelegateMock()
        let expectedCurrency = "AED"
        let mockedCurrency = "USDAED"
        
        // when
        sut.conversionViewModelDelegate = delegateMock
        sut.onInitialCurrencyChange(currency: mockedCurrency)
        
        // then
        
        XCTAssertEqual(expectedCurrency, delegateMock.givenInitialCurrency)
        
    }
    
    func testOnFinalCurrencyChange() {
        // given
        let serviceMock = ServiceMock()
        let sut = ConversionViewModel(repository: serviceMock)
        let delegateMock = ConversionViewModelDelegateMock()
        let expectedCurrency = "AED"
        let mockedCurrency = "USDAED"
        
        // when
        sut.conversionViewModelDelegate = delegateMock
        sut.onFinalCurrencyChange(currency: mockedCurrency)
        
        // then
        
        XCTAssertEqual(expectedCurrency, delegateMock.givenFinalCurrency)
    }
}

class ConversionViewModelDelegateMock: ConversionViewModelDelegate{
    var givenValue: Float?
    var givenInitialCurrency: String?
    var givenFinalCurrency: String?
    
    func convertedValueDidChange(value: Float) {
        givenValue = value
    }
    
    func initialCurrencyDidChange(currency: String) {
        givenInitialCurrency = currency
    }
    
    func finalCurrencyDidChange(currency: String) {
        givenFinalCurrency = currency
    }
}

class ServiceMock: ServiceProtocol {
    var quotationResult: Result<QuotationLive, RepositoryError>?
    
    func fetchCurrencyList(completion: @escaping (Result<Currencies, RepositoryError>) -> Void) {
        
    }
    
    func fetchQuotationLive(completion: @escaping (Result<QuotationLive, RepositoryError>) -> Void) {
        guard let quotationResult = quotationResult else {
            return
        }
        
        completion(quotationResult)
    }
    
    
}
