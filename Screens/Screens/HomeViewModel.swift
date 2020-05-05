//
//  HomeViewModel.swift
//  Screens
//
//  Created by Gustavo Amaral on 04/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation
import Combine
import Storage
import Networking
import Models
import Service

class HomeViewModel: Publisher {
    
    typealias Output = Model
    typealias Failure = HomeViewModelError
    
    private let storage = Services.make(Storage.self)
    private let requester = Services.make(Requester.self)
    private let publisher = PassthroughSubject<Model, HomeViewModelError>()
    private var cancellable: AnyCancellable?
    @Configured(valueKey: "com.almeidaws.Currency.quota", defaultValue: ("USD", "BRL")) private(set) var quote: (String, String)
    
    func receive<S>(subscriber: S) where S : Subscriber, HomeViewModelError == S.Failure, Model == S.Input {
        publisher.receive(subscriber: subscriber)
        deliver(to: subscriber)
    }
    
    private func deliver<S>(to subscriber: S) where S : Subscriber, HomeViewModelError == S.Failure, Model == S.Input {
        cancellable = readQuotes()
            .merge(with: fetchQuotes())
            .map { quotes in
                let (first, second) = self.quote
                let `default` = quotes.first { quote in quote.model.first == first && quote.model.second == second }
                return Model(default: `default`, quotes: quotes)
            }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.publisher.send(completion: .failure(error))
                    self.publisher.send(completion: .finished)
                case .finished:
                    break
                }
            },
                  receiveValue: { result in self.publisher.send(result) })
    }
    
    private func fetchQuotes() -> AnyPublisher<[Row<Quote>], HomeViewModelError> {
        return requester.realTimeRates()
            .mapError { error in HomeViewModelError.network(error) }
            .flatMap { quotes in self.storage.write(quotes).mapError { error in HomeViewModelError.storage(error)} }
            .flatMap { _ in self.storage.read().mapError { error in HomeViewModelError.storage(error)} }
            .eraseToAnyPublisher()
    }
    
    private func readQuotes() -> AnyPublisher<[Row<Quote>], HomeViewModelError> {
        let quotesPublisher: AnyPublisher<[Row<Quote>], StorageError> = storage.read()
        return quotesPublisher.mapError { error in HomeViewModelError.storage(error) }.eraseToAnyPublisher()
    }
    
    struct Model {
        let `default`: Row<Quote>!
        let quotes: [Row<Quote>]
    }
}

enum HomeViewModelError: Error {
    case storage(StorageError)
    case network(RequestError)
    
    var description: String {
        switch self {
        case .storage(let error): return "Storage: \(error)"
        case .network(let error): return "Network: \(error)"
        }
    }
}
