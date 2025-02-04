//
//  APIViewModel.swift
//  MobileChallenge
//
//  Created by Gabriel Vicentin Negro on 18/11/24.
//

import Foundation
import Combine

class ListOfCurrencyViewModel {
    
    @Published var loading: Bool = false
    @Published var currencies: [String: String] = [:]
    @Published var filteredCurrencies: [String: String] = [:]
    
    private var cancellables = Set<AnyCancellable>()
    
    func getListOfCurrency() {
        guard let url = URL(string: "https://raw.githubusercontent.com/Banking-iOS/mock-interview/main/api/list.json") else {
            print("URL Inválida")
            return
        }
        
        self.loading = true
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Currency.self, decoder: JSONDecoder())
            .map { $0.currencies }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.loading = false
                if case .failure(let error) = completion {
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] listOfCurrency in
                self?.currencies = listOfCurrency
            })
            .store(in: &cancellables)
    }
    
    func filterListOfCurrency(searchText: String) {
        self.filteredCurrencies = self.currencies.filter({ $0.key.lowercased().contains(searchText.lowercased()) || $0.value.lowercased().contains(searchText.lowercased()) })
    }
    
    func resetFilterListOfCurrency() {
        self.filteredCurrencies = self.currencies
    }
    
}


enum APIError: Error {
    case requestError
    case invalidURL
    case invalidResponse
    case invalidData
}
