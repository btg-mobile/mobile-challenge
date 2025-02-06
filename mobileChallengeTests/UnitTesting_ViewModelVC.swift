//
//  UnitTesting_ViewModelVC.swift
//  mobileChallengeTests
//
//  Created by Henrique on 05/02/25.
//

import XCTest
@testable import mobileChallenge

final class UnitTesting_ViewModelVC: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_HomeControlerControllerViewModel_calculateConversion_shouldReturn29(){
        //given
        let homeControllerVM = HomeControllerViewModel()
        let value = 20
        
        //when
        homeControllerVM.firstCurrencyValue = 3.67
        homeControllerVM.secondCurrencyValue = 5.34
        
        //then
        XCTAssertLessThan(homeControllerVM.calculateConversion(value: Double(value)), 29.2)
        XCTAssertGreaterThan(homeControllerVM.calculateConversion(value: Double(value)), 29)
        
    }
    
    func test_HomeControlerControllerViewModel_updateSearchController_should(){
        //given
        let homeControllerVM = HomeControllerViewModel()
        let num1 = 3.67
        let num2 = 5.34
        
        //when
        homeControllerVM.firstCurrencyValue = 3.67
        homeControllerVM.secondCurrencyValue = 5.34
        homeControllerVM.invertCurrencies()
        
        //then
        XCTAssertEqual(homeControllerVM.firstCurrencyValue, num2)
        XCTAssertEqual(homeControllerVM.secondCurrencyValue, num1)
    }
    
    

}
