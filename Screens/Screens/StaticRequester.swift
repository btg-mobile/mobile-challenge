//
//  StaticRequester.swift
//  Networking
//
//  Created by Gustavo Amaral on 05/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation
import Combine
import Models
import Networking

class StaticRequester: Requester {
    
    private var response: AnyPublisher<RequestResponse, RequestError>!
    
    func request(at url: URL, method: HTTPMethod, headers: [String : String], queryParameters: [String : Any], body: Data?) -> AnyPublisher<RequestResponse, RequestError> {
        let bundle = Bundle(identifier: "com.almeidaws.Currency.Screens")!
        let url = bundle.url(forResource: "supported_currencies", withExtension: "txt")!
        let data = try! Data(contentsOf: url)
        return Just(RequestResponse.init(data: data, status: .ok, request: URLRequest(url: url)))
            .setFailureType(to: RequestError.self)
            .eraseToAnyPublisher()
    }
    
    func supportedCurrencies(_ bundle: Bundle = .main) -> AnyPublisher<[Currency], RequestError> {
        response = supportedCurrenciesResponse()
        return (self as Requester).supportedCurrencies(bundle)
    }
    
    func realTimeRates(_ bundle: Bundle = .main) -> AnyPublisher<[Quote], RequestError> {
        response = realTimeRatesResponse()
        return (self as Requester).realTimeRates(bundle)
    }
}

fileprivate func supportedCurrenciesResponse() -> AnyPublisher<RequestResponse, RequestError> {
    let url = Bundle.main.url(forResource: "supported_currencies", withExtension: "txt")!
    let data = try! Data(contentsOf: url)
    return Just(RequestResponse.init(data: data, status: .ok, request: URLRequest(url: url)))
        .setFailureType(to: RequestError.self)
        .eraseToAnyPublisher()
}

fileprivate func realTimeRatesResponse() -> AnyPublisher<RequestResponse, RequestError> {
    let url = Bundle.main.url(forResource: "supported_currencies", withExtension: "txt")!
    let data = try! Data(contentsOf: url)
    return Just(RequestResponse.init(data: data, status: .ok, request: URLRequest(url: url)))
        .setFailureType(to: RequestError.self)
        .eraseToAnyPublisher()
}
