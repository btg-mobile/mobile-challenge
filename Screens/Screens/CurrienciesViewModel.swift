//
//  CurrienciesViewModel.swift
//  Screens
//
//  Created by Gustavo Amaral on 04/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation
import Combine
import Models
import Storage
import Networking
import Service

class CurrenciesViewModel: Publisher {
    
    typealias Output = [Currency]
    typealias Failure = CurrenciesViewModelError
    
    func receive<S>(subscriber: S) where S : Subscriber, CurrenciesViewModelError == S.Failure, [Currency] == S.Input {
        let subscription = CurrenciesViewModelSubscription(subscriber)
        subscriber.receive(subscription: subscription)
    }
}

fileprivate class CurrenciesViewModelSubscription: Subscription {
    
    private let subscriber: AnySubscriber<[Currency], CurrenciesViewModelError>
    private let storage = Services.make(Storage.self)
    private let requester = Services.make(Requester.self)
    private var cancellables = Set<AnyCancellable>()
    
    init<S>(_ subscriber: S) where S : Subscriber, CurrenciesViewModelError == S.Failure, [Currency] == S.Input {
        self.subscriber = .init(subscriber)
    }
    
    func request(_ demand: Subscribers.Demand) {
        switch demand {
        case .unlimited:
            let networkPublisher = requester.supportedCurrencies()
                .mapError { CurrenciesViewModelError.network($0) }
                .eraseToAnyPublisher()
            
            let publisher: AnyPublisher<[Row<Currency>], StorageError> = storage.read()
            publisher
                .map { $0.map { $0.model }}
                .mapError { CurrenciesViewModelError.storage($0) }
                .merge(with: networkPublisher)
                .flatMap { self.storage.write($0).mapError { CurrenciesViewModelError.storage($0) } }
            .sink(receiveCompletion: { completion in self.subscriber.receive(completion: completion) }, receiveValue: { currencies in _ = self.subscriber.receive(currencies) }).store(in: &cancellables)
//            .subscribe(subscriber)
        default:
            fatalError("Not implemented")
        }
    }
    
    func cancel() {
        fatalError("Not implemented")
    }
}

enum CurrenciesViewModelError: Error, CustomStringConvertible {
    case storage(StorageError)
    case network(RequestError)
    
    var description: String {
        switch self {
        case .storage(let error): return "Storage: \(error)"
        case .network(let error): return "Network: \(error)"
        }
    }
}
