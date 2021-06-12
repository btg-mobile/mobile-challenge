//
//  List.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 29/11/20.
//

import Foundation

struct Live: Codable {
    let code: String
    let quote: Double
}

typealias Lives = [Live]

extension Lives {
    static let sample = [
        Live(code: "USDAED", quote: 3.673042),
        Live(code: "USDAFN", quote: 77.000368),
        Live(code: "USDALL", quote: 103.650403),
        Live(code: "USDAMD", quote: 508.210403)
    ]

    // Methods

    static func save(quotes: [String: Double]) {
        CommonData.shared.lives.removeAll()
        quotes.forEach {
            let live = Live(code: $0.key, quote: $0.value)
            CommonData.shared.lives.append(live)
        }
    }

    func finOne(by code: String) -> Live? {
        return self.first { $0.code == code }
    }
}
