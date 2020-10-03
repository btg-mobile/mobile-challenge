//
//  ListCurrencyResponse.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 03/10/20.
//

import Foundation

struct ListCurrencyResponse: Decodable {
    let success: Bool
    let terms: URL
    let privacy: URL
    let currencies: [String: String]
}

extension ListCurrencyResponse: Equatable {
    static func == (lhs: ListCurrencyResponse, rhs: ListCurrencyResponse) -> Bool {
        return lhs.success == rhs.success
            && lhs.terms == rhs.terms
            && lhs.privacy == rhs.privacy
            && lhs.currencies == rhs.currencies
    }
}
