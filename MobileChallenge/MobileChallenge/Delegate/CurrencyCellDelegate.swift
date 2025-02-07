//
//  CurrencyCellDelegate.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 05/02/25.
//

import Foundation

protocol CurrencyCellDelegate: AnyObject {
    func didSelectCurrency(currency: String)
}
