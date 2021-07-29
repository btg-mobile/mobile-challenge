//
//  HomeViewDelegateProtocol.swift
//  Coin Converter
//
//  Created by Igor Custodio on 28/07/21.
//

import Foundation

protocol HomeViewDelegate {
    func currencyListLoaded()
    func quotesListLoaded()
    func showAlertError(title: String, message: String)
    func showLoading()
    func hideLoading()
    func currencyConverted()
}
