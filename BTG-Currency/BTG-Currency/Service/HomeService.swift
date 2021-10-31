//
//  HomeService.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 27/10/21.
//

import Foundation
import Combine

public class HomeService {
    public func fetchLive(fromCurrency input: Currency, toCurrencySymbol output: String) -> AnyPublisher<Decimal, ServiceError> {
        Network(Endpoints.live.url)
            .request(LiveDTO.self)
            .tryMap { liveDTO in
                guard let quotes = liveDTO.quotes, !quotes.isEmpty else {
                    throw ServiceError.isEmpty
                }
                
                let outputCurrency = quotes["USD"+output] ?? 0.0
                let inputCurrency = quotes["USD"+input.symbol] ?? 0.0
                
                let inputValue = input.value
                let outputValue = inputValue / inputCurrency * outputCurrency
                
                return outputValue
            }
            .mapError { error in
                switch error {
                case is URLError:
                    return .sessionFailed
                case ServiceError.isEmpty:
                    return .isEmpty
                default:
                    return .unknown
                }
            }
            .eraseToAnyPublisher()
    }
}
