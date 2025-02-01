//
//  ConversionVMTests.swift
//  Mobile Challenge
//
//  Created by Vinicius Serpa on 20/11/24.
//

import XCTest
@testable import Mobile_Challenge

class ConversionVMTests: XCTestCase {

    func testFetchConvertionsCalculation() async throws {
        let conversionViewModel = ConversionViewModel()
        
        // Configuração dos dados
        conversionViewModel.currencyVM.currencyNames = [
            CurrencyNameModel(code: "USD", name: "United States Dollar"),
            CurrencyNameModel(code: "BRL", name: "Brazilian Real")
        ]
        conversionViewModel.currencyVM.currencyValues = [
            CurrencyValueModel(quotes: ["USD": 1.0]),
            CurrencyValueModel(quotes: ["BRL": 5.42])
        ]
        
        // Chamada da função assíncrona
        await conversionViewModel.fetchConvertions()
        
        // Verificações após a execução
        XCTAssertEqual(conversionViewModel.convertions.count, 2)
        XCTAssertEqual(conversionViewModel.convertions[0].dolarValue, 1.0)
        XCTAssertEqual(conversionViewModel.convertions[1].code, "BRL")
    }
}
