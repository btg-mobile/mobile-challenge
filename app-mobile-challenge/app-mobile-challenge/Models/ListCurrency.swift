//
//  ListCurrency.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 29/11/20.
//

import Foundation
import Combine

struct ListCurrency: Codable {
    public var success: Bool
    public var terms: URL
    public var privacy: URL
    public var currencies: [String: String]
}

extension ListCurrency {
    static func getFromWeb(completion: @escaping () -> Void) {
        var publishers = [AnyCancellable]()
        CurrencyApi.shared.lists()
            .map { $0 }
            .sink(receiveCompletion: { _ in debugPrint("A requisição terminou...") },
                  receiveValue: {
                    Lists.save(currencies: $0.currencies)
                    completion()
            })
            .store(in: &publishers)
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 1))
        withExtendedLifetime(publishers, {})
    }
}
