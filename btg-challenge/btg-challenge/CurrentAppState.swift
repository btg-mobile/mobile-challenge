//
//  CurrentState.swift
//  btg-challenge
//
//  Created by Wesley Araujo on 14/09/20.
//  Copyright © 2020 Wesley Araujo. All rights reserved.
//

import Foundation

class CurrentAppState {
    static let shared = CurrentAppState()
    
    private var sourceCurrentCurrency: [String: String]
    private var destinyCurrentCurrency: [String: String]
    
    private init() {
        sourceCurrentCurrency = ["BRL": "Real"]
        destinyCurrentCurrency = ["USD": "Dollar"]
    }
    
    func getSourceCurrentCurrency() -> [String: String] {
        return sourceCurrentCurrency
    }
    
    func getDestinyCurrentCurrency() -> [String: String] {
        return destinyCurrentCurrency
    }
    
    func setSourceCurrentCurrency(_ currency: [String: String]) {
        sourceCurrentCurrency = currency
    }
    
    func setDestinyCurrentCurrency(_ currency: [String: String]) {
        destinyCurrentCurrency = currency
    }

}
