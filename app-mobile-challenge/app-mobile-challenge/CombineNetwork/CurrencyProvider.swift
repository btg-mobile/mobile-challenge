//
//  CurrencyFactProvider.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 29/11/20.
//

import Combine

/// Possíveis terminações de erro.
enum APIError: Error {
    case internalError
    case serverError
    case parsingError
}

/// Protocolo de comunicação que define os métodos empregados pela API.
protocol CurrencyProvider {
    // MARK: Combine
    func lists() -> AnyPublisher<ListCurrency, APIError>
    func lives() -> AnyPublisher<LiveCurrency, APIError>
}
