//
//  CurrencyRepository.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 29/03/21.
//

class CurrencyRepository: CurrencyRepositoryProtocol {
    var network: Networking

    init(network: Networking) {
        self.network = network
    }
}
