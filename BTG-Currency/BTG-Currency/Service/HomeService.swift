//
//  HomeService.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 27/10/21.
//

import Foundation
import Combine

public class HomeService {
    public func fetchLive(fromCurrency input: Currency, toCurrencySymbol output: String) -> AnyPublisher<Currency, Error> {
        Network(Endpoints.live.url)
            .request(LiveDTO.self)
            .map({ liveDTO in
                let outputCurrency = liveDTO.quotes?["USD"+output] ?? 0.0
                let inputCurrency = liveDTO.quotes?["USD"+input.symbol] ?? 0.0
                
                let inputValue = input.value
                let outputValue = inputValue / inputCurrency * outputCurrency
                
                return Currency(value: outputValue, symbol: output)
            })
            .eraseToAnyPublisher()
    }
}
