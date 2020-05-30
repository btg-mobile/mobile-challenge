//
//  CoinListTests.swift
//  Desafio iOSTests
//
//  Created by Lucas Soares on 30/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import XCTest
@testable import RxSwift
@testable import RxCocoa

class CoinListTests: XCTestCase {

    var coinListViewModel: CurrencyListViewModelProtocol?
    var filteredCount = 0
    
    override func setUpWithError() throws {
        coinListViewModel = CoinListViewModelTests()
        coinListViewModel?.getList()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        coinListViewModel = nil
    }
    
    func testViewModel() throws {
        XCTAssert(coinListViewModel != nil)
    }

    
    func testGetList() throws {
        coinListViewModel?.filterList(predicate: "").subscribe(onNext: { filteredList in
            XCTAssert(filteredList.count == 4)
        }).disposed(by: coinListViewModel!.disposeBag)
    }
    
    func testFilterList() throws {
        coinListViewModel?.filterList(predicate: "USD").subscribe(onNext: { filteredList in
            XCTAssert(filteredList.count == 1)
        }).disposed(by: coinListViewModel!.disposeBag)
    }

}
