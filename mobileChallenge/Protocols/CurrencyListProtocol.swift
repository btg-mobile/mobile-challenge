//
//  CurrencyListDelegate.swift
//  mobileChallenge
//
//  Created by Henrique on 05/02/25.
//

import Foundation

protocol CurrencyListProtocol: AnyObject {
    func selectedCurrency(code: String, selected: Int)
}
