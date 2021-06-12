//
//  LiveCurrency.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 29/11/20.
//

import Foundation
import Combine

/// Representação do serviço responsável pelas taxação das moedas.
struct LiveCurrency: Codable {
    public var success: Bool
    public var terms: URL
    public var privacy: URL
    public var timestamp: Int
    public var source: String
    public var quotes: [String: Double]
}

extension LiveCurrency {
    /// Serviço de captura da `LiveCurrency` na Web.
    static func getFromWeb(completion: @escaping () -> Void) {
        var publishers = [AnyCancellable]()
        CurrencyApi.shared.lives()
            .map { $0 }
            .sink(receiveCompletion: { _ in debugPrint("A requisição terminou...") },
                  receiveValue: {
                    CommonData.shared.lastUpdate = $0.timestamp
                    Lives.save(quotes: $0.quotes)
                    completion()
            })
            .store(in: &publishers)
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 2))
        withExtendedLifetime(publishers, {})
    }
}
