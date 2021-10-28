//
//  ListViewModel.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 27/10/21.
//

import Combine
import Foundation

public class ListViewModel {
    @Published private(set) var items: [ListItem] = []
    
    private let service: ListService
    private var cancellables: Set<AnyCancellable>
    
    public init(service: ListService) {
        self.service = service
        self.cancellables = Set<AnyCancellable>()
    }
    
    public func fetchList() {
        service.fetchList()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] list in
                self?.items = list
            }.store(in: &cancellables)
    }
}
