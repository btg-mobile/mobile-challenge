//
//  HomeViewModel.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 27/10/21.
//

import Combine
import Foundation

public class HomeViewModel {
    //MARK: - Published attributes
    private(set) var inputSymbol: String = ""
    private(set) var inputValue: Decimal = 0.0
    private(set) var outputSymbol: String = ""
    private(set) var outputValue: Decimal = 0.0
    
    //MARK: - Service attribute
    private let service: HomeService
    
    //MARK: - Combine attributes
    private var cancellables: Set<AnyCancellable>
    
    private var inputValuePublisher = PassthroughSubject<String, Never>().eraseToAnyPublisher()
    private var inputSymbolPublisher = PassthroughSubject<String, Never>().eraseToAnyPublisher()
    private var outputSymbolPublisher = PassthroughSubject<String, Never>().eraseToAnyPublisher()
    
    private var convertSubject = PassthroughSubject<Result<String, ServiceError>, Never>()
    var convertPublisher: AnyPublisher<Result<String, ServiceError>, Never> {
        convertSubject.eraseToAnyPublisher()
    }
    
    private var connectivitySubject = PassthroughSubject<Bool, Never>()
    var connectivityPublisher: AnyPublisher<Bool, Never> {
        ConnectivityMonitor.shared.publisher
    }
    
    
    //MARK: - Initializer
    public init(service: HomeService) {
        self.service = service
        self.cancellables = Set<AnyCancellable>()
    }
}

//MARK: - Binding
extension HomeViewModel {
    public func attachInputValueListener(_ publisher: AnyPublisher<String, Never>) {
        self.inputValuePublisher = publisher
        self.inputValuePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.inputValue = value.toDecimal()
            }.store(in: &cancellables)
    }
    
    public func attachInputSymbolListener(_ publisher: AnyPublisher<String, Never>) {
        self.inputSymbolPublisher = publisher
        self.inputSymbolPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] code in
                self?.inputSymbol = code
            }.store(in: &cancellables)
    }
    
    public func attachOutputSymbolListener(_ publisher: AnyPublisher<String, Never>) {
        self.outputSymbolPublisher = publisher
        self.outputSymbolPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] code in
                self?.outputSymbol = code
            }.store(in: &cancellables)
    }
}

//MARK: - Service calls
extension HomeViewModel {
    public func convert() {
        guard inputSymbol != outputSymbol else {
            self.outputValue = inputValue
            self.convertSubject.send(.success(outputValue.toCurrency(withCode: outputSymbol)))
            return
        }
        
        let input = Currency(value: inputValue, symbol: inputSymbol)
        service.fetchLive(fromCurrency: input, toCurrencySymbol: outputSymbol)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.convertSubject.send(.failure(error))
                }
            } receiveValue: { [weak self] value in
                self?.outputValue = value
                if let symbol = self?.outputSymbol {
                    let string = value.toCurrency(withCode: symbol)
                    self?.convertSubject.send(.success(string))
                }
            }.store(in: &cancellables)
    }
}

