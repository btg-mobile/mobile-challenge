//
//  HomeViewModel.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 27/10/21.
//

import Combine
import Foundation

public class HomeViewModel {
    @Published var input = Currency(symbol: "BRL")
    @Published var output = Currency()
    
    private let service: HomeService
    private var cancellables: Set<AnyCancellable>
    
    public init(service: HomeService) {
        self.service = service
        self.cancellables = Set<AnyCancellable>()
    }
    
    public func fetchCurrency() {
        service.fetchLive(fromCurrency: input, toCurrencySymbol: output.symbol)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] currency in
                self?.output = currency
            }.store(in: &cancellables)
    }
}

