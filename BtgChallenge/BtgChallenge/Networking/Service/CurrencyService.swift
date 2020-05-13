//
//  CurrencyService.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 13/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

typealias LiveResult = Result<LiveResponse, Error>
typealias ConvertResult = Result<ConvertResponse, Error>

protocol CurrencyService {
    func live(_ currencies: String, _ source: String, _ callback: @escaping (LiveResult) -> Void)
    func convert(_ fromCoin: String, _ toCoin: String, _ amount: String, _ callback: @escaping (ConvertResult) -> Void)
}
