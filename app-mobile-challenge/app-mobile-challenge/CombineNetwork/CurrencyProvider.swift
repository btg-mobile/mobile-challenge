//
//  CurrencyFactProvider.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 29/11/20.
//

import Combine

enum APIError: Error {
    case internalError
    case serverError
    case parsingError
}

protocol CurrencyProvider {
    // MARK: Combine
    func lists() -> AnyPublisher<ListCurrency, APIError>
    func lives() -> AnyPublisher<LiveCurrency, APIError>
}
