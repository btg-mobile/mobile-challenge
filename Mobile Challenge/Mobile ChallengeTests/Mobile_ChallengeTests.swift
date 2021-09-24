//
//  Mobile_ChallengeTests.swift
//  Mobile ChallengeTests
//
//  Created by Daive Costa Nardi Simões on 23/09/21.
//

import XCTest
@testable import Mobile_Challenge

class Mobile_ChallengeTests: XCTestCase {

    // MARK: - Private properties
    
    private var mockedError = NSError(domain: "MockedErrorDomain", code: -999, userInfo: nil)
    private var mockedCurrentDollarQuoteDTO = CurrentDollarQuoteDTO(success: true, source: "USD", quotes: ["USDBRL" : 5.0])
    private var mockedCurrenciesDTO = CurrenciesDTO(success: true, currencies: ["USD" : "Dolar Americano", "BRL" : "Real Brasileiro"])
    
    func testGetCurrenciesWithSucess() {
        let useCase = ListCurrencyUseCase(currencyRepository: CurrencyMockedRepository(mockedCurrenciesDTO: mockedCurrenciesDTO, mockedCurrentDollarQuoteDTO: nil, mockedError: nil))
        
        useCase.listCurrencies { currencies, error in
            XCTAssertNil(error)
            XCTAssertEqual(currencies?.list.count, 2)
        }
    }
    
    func testGetCurrenciesWithError() {
        let useCase = ListCurrencyUseCase(currencyRepository: CurrencyMockedRepository(mockedCurrenciesDTO: mockedCurrenciesDTO, mockedCurrentDollarQuoteDTO: nil, mockedError: mockedError))
        
        useCase.listCurrencies { _ , error in
            XCTAssertNotNil(error)
        }
    }
    
    func testConverterCurrencyWithSucess() {
        let useCase = ConverterUseCase(currencyRepository: CurrencyMockedRepository(mockedCurrenciesDTO: nil, mockedCurrentDollarQuoteDTO: mockedCurrentDollarQuoteDTO, mockedError: nil))
        
        useCase.convertCurrency(from: "USD", to: "BRL") { quote, error in
            XCTAssertNil(error)
            XCTAssertEqual(quote, 5.0)
        }
    }
    
    func testConverterCurrencyWithError() {
        let useCase = ConverterUseCase(currencyRepository: CurrencyMockedRepository(mockedCurrenciesDTO: nil, mockedCurrentDollarQuoteDTO: mockedCurrentDollarQuoteDTO, mockedError: mockedError))
        
        useCase.convertCurrency(from: "USD", to: "BRL") { quote, error in
            XCTAssertNotNil(error)
        }
    }

}
