//
//  CurrencyRepositoryImpl.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 13/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

final class CurrencyRepositoryImpl: CurrencyRepository {
    
    let provider: HTTPProvider<CurrencyRouter>
    
    init(provider: HTTPProvider<CurrencyRouter>) {
        self.provider = provider
    }
    
    func live(_ currencies: String,
              _ source: String,
              _ callback: @escaping (LiveResult) -> Void
    ) {
        provider.request(router: .live(currencies, source)) { result in
            callback(result)
        }
    }
    
    func convert(_ fromCoin: String,
                 _ toCoin: String,
                 _ amount: String,
                 _ callback: @escaping (ConvertResult) -> Void
    ) {
        provider.request(router: .convert(fromCoin, toCoin, amount)) { result in
            callback(result)
        }
    }
    
    func list(_ callback: @escaping (ListResult) -> Void) {
        provider.request(router: .list) { result in
            callback(result)
        }
    }
    
}
