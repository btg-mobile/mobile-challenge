//
//  CoinConversionTests.swift
//  Desafio iOSTests
//
//  Created by Lucas Soares on 31/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import XCTest
@testable import RxSwift
@testable import RxCocoa

class CoinConversionTests: XCTestCase {
    
    var viewModel: CoinConversionViewModelTests?
    
    override func setUpWithError() throws {
        
        viewModel = CoinConversionViewModelTests()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        
        viewModel = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testViewModel() throws {
        XCTAssert(viewModel != nil)
    }
    
    func testAmountEmpty() throws {
        viewModel?.getConversionValue()
        
        XCTAssert(viewModel?.error.value != nil)
        XCTAssert(viewModel?.error.value == Constants.Messages.coinConversionError)
    }
    
    func testConversionAnyCoinToUSD() throws {
        let EXPECTED_AMOUNT = "1250"
        let currencyBrl = FormattedCurrency(currencyCode: "BRL", currencyName: "Brazilian Real")
        let currencyUSD = FormattedCurrency(currencyCode: "USD", currencyName: "United States Dollar")
        
        viewModel?.didSelectNewCurrency(formattedCurrency: currencyBrl, source: .from)
        viewModel?.didSelectNewCurrency(formattedCurrency: currencyUSD, source: .to)
        
        XCTAssert(viewModel?.selectedCurrencyFrom.value != nil)
        XCTAssert(viewModel?.selectedCurrencyFrom.value!.currencyCode == currencyBrl.currencyCode)
        
        XCTAssert(viewModel?.selectedCurrencyTo.value != nil)
        XCTAssert(viewModel?.selectedCurrencyTo.value!.currencyCode == currencyUSD.currencyCode)
        
        viewModel?.amount.accept(EXPECTED_AMOUNT.currencyFormatted)
        
        viewModel?.EXPECTED_RATE = 5.42
        
        viewModel?.getConversionValue()
        
        XCTAssert(viewModel?.finalValue.value != nil)
        
        XCTAssert(viewModel?.finalValue.value == (EXPECTED_AMOUNT.double / self.viewModel!.EXPECTED_RATE).stringValue.currencyFormatted)
    }
    
    
    func testConvertAnyCoinToAnyCoin() throws {
        //conversion rates must be real
        let EXPECTED_AMOUNT = "1000"
        let EURO_BRL_RATE = 5.92
        let currencyBrl = FormattedCurrency(currencyCode: "EUR", currencyName: "EUR")
        let anyCurrency = FormattedCurrency(currencyCode: "BRL", currencyName: "Brazilian Real")
        
        viewModel?.didSelectNewCurrency(formattedCurrency: currencyBrl, source: .from)
        viewModel?.didSelectNewCurrency(formattedCurrency: anyCurrency, source: .to)
        
        XCTAssert(viewModel?.selectedCurrencyFrom.value != nil)
        XCTAssert(viewModel?.selectedCurrencyFrom.value!.currencyCode == currencyBrl.currencyCode)
        
        XCTAssert(viewModel?.selectedCurrencyTo.value != nil)
        XCTAssert(viewModel?.selectedCurrencyTo.value!.currencyCode == anyCurrency.currencyCode)
        
        viewModel?.amount.accept(EXPECTED_AMOUNT.currencyFormatted)
        
        viewModel?.EXPECTED_INTERMEDIARY_RATE = 5.334 //usd to brl rate
        
        viewModel?.EXPECTED_RATE = 0.900 //eur to usd rate
        
        viewModel?.getConversionValue()
        
        XCTAssert(viewModel?.finalValue.value != nil)
        
        XCTAssert(Int(viewModel?.finalValue.value ?? "0") == Int((EXPECTED_AMOUNT.double / EURO_BRL_RATE).stringValue.currencyFormatted)) //comparing only integer value due to cents difference
    }
}
