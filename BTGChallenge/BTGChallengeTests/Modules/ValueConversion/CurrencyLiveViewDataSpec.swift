//
//  CurrencyLiveViewDataSpec.swift
//  BTGChallengeTests
//
//  Created by Gerson Vieira on 17/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit
import Quick
import Nimble
import Moya
@testable import BTGChallenge

class CurrencyLiveViewDataSpec: QuickSpec {
    
    var viewData: [CurrencyLiveViewData]!
    var quots: [String: Double]!
    override func spec() {
        describe("CurrencyLiveViewDataSpec") {
            beforeEach {
                let provider = MoyaProvider<ConvertCurrencyRouter>()
                let service = CurrencyLiveService(provider: provider)
                let viewModel = CurrencyLiveViewModel(service: service)
                self.quots = ["moeda 1": 3.9, "moeda2": 2.7, "moeda3": 0.5]
                self.viewData = viewModel.formartList(currencies: self.quots)
            }
            
            afterEach {
                self.viewData = nil
            }
            
            it("testViewData") {
                expect(self.viewData).toNot(beNil())
                expect(self.viewData[0].currencyCode).to(equal("moeda1"))
                expect(self.viewData[0].CurrencyQuote).to(equal(0.3))
            }
            
        }
    }
}

