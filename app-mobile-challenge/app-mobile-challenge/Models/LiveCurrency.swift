//
//  LiveCurrency.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 29/11/20.
//

import Foundation
import Combine

struct LiveCurrency: Codable {
    public var success: Bool
    public var terms: URL
    public var privacy: URL
    public var timestamp: Int
    public var source: String
    public var quotes: [String: Double]
}

extension LiveCurrency: Equatable {
    static func == (lhs: LiveCurrency, rhs: LiveCurrency) -> Bool {
        return lhs.success == rhs.success
            && lhs.terms == rhs.terms
            && lhs.privacy == rhs.privacy
            && lhs.timestamp == rhs.timestamp
            && lhs.source == rhs.source
            && lhs.quotes == rhs.quotes
    }
    
    static func getFromWeb() {
        var publishers = [AnyCancellable]()
        CurrencyApi.shared.lives()
            .map { $0 }
            .sink(receiveCompletion: { _ in print("A requisição terminou...") },
                  receiveValue: {
                    CommonData.shared.lastUpdate = $0.timestamp
                    Live.save(quotes: $0.quotes)
            })
            .store(in: &publishers)
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 10))
        withExtendedLifetime(CurrencyApi.shared.lives, {})
    }
}
