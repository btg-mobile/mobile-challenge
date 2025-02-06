//
//  UnitTesting_CurrencyListViewModel.swift
//  mobileChallengeTests
//
//  Created by Henrique on 05/02/25.
//

import XCTest
@testable import mobileChallenge

final class UnitTesting_CurrencyListViewModel: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_CurrencyListViewModel_inSearchMode_shouldReturnFalse(){
        //given
        let clistVM = CurrencyListControllerViewModel()
        let sController = UISearchController()
        
        //when
        let ope = clistVM.inSearchMode(sController)
        
        //then
        XCTAssertFalse(ope)
    }

}
