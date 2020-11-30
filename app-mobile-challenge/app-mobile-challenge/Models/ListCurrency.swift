//
//  ListCurrency.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 29/11/20.
//

import Foundation
import Combine

/// Representação do serviço responsável pelas lista de moedas.
struct ListCurrency: Codable {
    public var success: Bool
    public var terms: URL
    public var privacy: URL
    public var currencies: [String: String]
}

extension ListCurrency {
    /// Serviço de captura da `LiveCurrency` na Web.
    static func getFromWeb() {
        var publishers = [AnyCancellable]()
        CurrencyApi.shared.lists()
            .map { $0 }
            .sink(receiveCompletion: { _ in debugPrint("A requisição terminou...") },
                  receiveValue: {
                    Lists.save(currencies: $0.currencies)
            })
            .store(in: &publishers)
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 1))
        withExtendedLifetime(publishers, {})
    }
}
