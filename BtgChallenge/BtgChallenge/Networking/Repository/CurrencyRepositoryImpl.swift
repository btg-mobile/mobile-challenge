//
//  CurrencyRepositoryImpl.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 13/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

final class CurrencyRepositoryImpl: CurrencyRepository {
    
    var service: CurrencyService
    
    init(service: CurrencyService) {
        self.service = service
    }
    
    func live(_ currencies: String,
              _ source: String,
              _ callback: @escaping (LiveResult) -> Void
    ) {
        service.live(currencies, source) { (liveResult) in
            callback(liveResult)
        }
    }
    
    func convert(_ fromCoin: String,
                 _ toCoin: String,
                 _ amount: String,
                 _ callback: @escaping (ConvertResult) -> Void
    ) {
        service.convert(fromCoin, toCoin, amount) { (convertResult) in
            callback(convertResult)
        }
    }
    
}
