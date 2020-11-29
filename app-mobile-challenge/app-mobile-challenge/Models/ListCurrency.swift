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

extension ListCurrency: Equatable {
    static func == (lhs: ListCurrency, rhs: ListCurrency) -> Bool {
        return lhs.success == rhs.success
            && lhs.terms == rhs.terms
            && lhs.privacy == rhs.privacy
            && lhs.currencies == rhs.currencies
    }
    
    static func getFromWeb() {
        var publishers = [AnyCancellable]()
        CurrencyApi.shared.lists()
            .map { $0 }
            .sink(receiveCompletion: { _ in print("A requisição terminou...") },
                  receiveValue: {
                    List.save(currencies: $0.currencies)
            })
            .store(in: &publishers)
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 10))
        withExtendedLifetime(CurrencyApi.shared.lists, {})
    }
}
